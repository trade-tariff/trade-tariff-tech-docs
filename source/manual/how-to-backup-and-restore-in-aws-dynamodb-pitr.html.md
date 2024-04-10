---
owner_slack: "#trade-tariff-infrastructure"
title: Restore tables in AWS DynamoDB using PITR
section: Backups
layout: manual_layout
parent: "/manual.html"
---

This playbook describes how to restore a table using Amazon's [DynamoDB PITR][dynamodb-pitr].

We use DynamoDB Point in Time Recovery (PITR) backups to keep 35 days worth of
changes to a configured dynamodb table.

> Most dynamodb tables - for instance those used for terraform locks, do not include
> this functionality.

## Prerequisites

1. AWS account configured with the correct permissions
2. Any browser

## Restore a DynamoDB table via the AWS Console

The procedure for restoring a DynamoDB table using PITR is as follows:

1. Navigate to DynamoDB > Tables > your table
2. Select the Backups tab
3. Click Restore
4. Choose a name for your table (for example `CustomerApiKeys-restored`)
5. Pick eith the latest snapshot or specify a date and time where the data was last in a good state
6. Decide whether you need secondary indexes restored (pick `Restore the entire table`)
7. Choose `Same Region` for the region
8. Choose `Owned by Amazon DynamoDB` for the encryption keys
9. Select Restore at the bottom of the form

Once the newly-restored table is available, you will need to configure your application to use it.

> We recommend using environment variables to easily update your table names in your ECS application/lambda

![Screenshot of the DynamoDB PITR form](images/aws/dynamodb-pitr-restoring-form.png)
![Screenshot of the DynamoDB table restoring](images/aws/dyanmodb-pitr-restoring.png)

[dynamodb-pitr]: https://github.com/trade-tariff/trade-tariff-lambdas-database-backups
