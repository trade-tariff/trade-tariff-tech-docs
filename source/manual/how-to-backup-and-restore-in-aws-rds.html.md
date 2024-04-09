---
owner_slack: "#trade-tariff-infrastructure"
title: Backup and restore databases in AWS RDS
section: Backups
layout: manual_layout
parent: "/manual.html"
---

This playbook describes how to restore a database instance using Amazon's [RDS Backups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html) feature.

We use RDS Backups to give us full nightly backups and point-in-time recovery (PITR) (also known as continuous data protection or CDP).

<!-- Force markdown to separate these quotes -->
> We also generate automated backups using a [backups lambda][lambda-backups]. These are stored in an s3 bucket per environment but do not include a snapshot history.

## Restore an RDS instance via the AWS CLI

This documentation will illustrate how to restore a database (DB) instance from a DB Snapshot with AWS CLI.

Before you get started you need to know:

* The environment in which you are restoring the database - replace <environment> throughout the scripts
* The name of the database which needs to be restored - if you are restoring multiple databases, you will need to carry out these steps again for it

For more information, read the [AWS documentation on Restoring from a DB Snapshot](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_RestoreFromSnapshot.html).

### 1. Retrieve the relevant database information

In this example, we're using `describe-db-instances` to identify the instances we want a snapshot for.

```sh
# Find the database you want to find snapshots for (easily identified by its name)
aws rds describe-db-instances | jq '.DBInstances | .[] | {DBInstanceIdentifier, DBName}'
DATABASE_ID="<replace_with_previous_output>"
```

Find and export the relevant VPC and Security Group configuration for your RDS restore

```sh
aws rds describe-db-instances \
 --db-instance-identifier terraform-20230623123439228000000001 \
 --query 'DBInstances[].[VpcSecurityGroups[].VpcSecurityGroupId,DBParameterGroups[].DBParameterGroupName,DBSubnetGroup.DBSubnetGroupName]'
```

Example of the output:

* vpc-security-group-id = sg-XXXXXXXX
* db-parameter-group-name = local-links-manager-postgres-XXXXXXXXXX
* db-subnet-group-name = blue-govuk-rds-subnet

Now export the result:

```sh
DB_SUBNET_GROUP_NAME="<replace_with_previous_output>"
VPC_SECURITY_GROUP_ID="<replace_with_previous_output>" # A comma-separated list of sg ids
DB_PARAMETER_GROUP_NAME="<replace_with_previous_output>"
```

### 2. Retrieve a list of all snapshot ARNs for your database name

```sh
aws rds describe-db-snapshots | jq '.DBSnapshots | .[] | select(.DBInstanceIdentifier = "$DATABASE_ID") | {DBInstanceIdentifier, DBSnapshotIdentifier}'

# Decide which snapshot you want and set its identifier below
SNAPSHOT_IDENTIFIER="<replace_with_previous_output>"
```

### 3. Restore the database instance from a snapshot

> The restored database must have the same security groups and be in the same VPC (that's the "subnet group name" parameter) as the original one, otherwise, apps won't be able to connect to it. Therefore the database needs to be restored in the same VPC and with the same security groups as the original instance the snapshot came from.

Using the stored variables from the previous steps:

```sh
aws rds restore-db-instance-from-db-snapshot \
  --db-subnet-group-name $DB_SUBNET_GROUP_NAME \
  --db-instance-identifier restored-$DATABASE_ID \
  --db-snapshot-identifier $SNAPSHOT_ARN \
  --vpc-security-group-ids $VPC_SECURITY_GROUP_ID
```

To see the newly created database instance, log into AWS Console > RDS > Databases > filter for your database name. You should see the original and newly created one.

### 4. Test the database has been fully restored

Before moving on to the next step we need to ensure that the database has been fully restored and is ready to be used:

```sh
aws rds wait db-instance-available --db-instance-identifier restored-${DATABASE_ID}
```

This command will wait until the database is ready, and then exit without any output.

### 5. Get the new database's hostname

Make a note of the new endpoint address:

```sh
aws rds describe-db-instances \
  --db-instance-identifier "restored-${DATABASE_ID}" \
  --query 'DBInstances[].Endpoint.Address'
```

### 6. Update the existing secrets manager secret value

This requires updating the existing secrets manager secret for the database you've just restored

1. Log in to AWS in the correct environment: `development, staging or production`
1. In AWS Secrets Manager, search for and click on the relevant secret
1. Under the "Overview" tab, in the "Secret Value" section, select "Retrieve Secret Value".
1. Make a note of the existing value, in case you need to revert the changes (for example, if performing a drill).
1. Click "Edit", and replace the value of the `host` and `dbInstanceIdentifier` fields with the URL and identifier of the new database instance. Click "Save".

### 7. Redeploy the affected ECS applications

> The execution role in ECS passes secret values to a new revision of the application. This process is triggered by a standard deployment using terraform with a new docker image.

1. Open an empty PR you want to cut a release for
1. Seek approval to merge this PR (for `staging` and `production` releases)
1. Manually gated production releases will need to be approved after the staging workflow has completed

You'll want to keep an eye on the `#tariff-alerts` channel and validate the application is still running using your usual process.

[lambda-backups]: https://github.com/trade-tariff/trade-tariff-lambdas-database-backups
