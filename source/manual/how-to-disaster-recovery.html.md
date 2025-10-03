---
owner_slack: "#trade-tariff-infrastructure"
title: Disaster Recovery Runbook
section: Backups
layout: manual_layout
parent: "/manual.html"
---

This runbook contains instructions for deploying or restoring all or part of the Service in the event of a **Disaster**.

## Deploying Services

To restore service functionality, follow the procedure that matches the part(s) of the service that are degraded.

## Deploying Core Infrastructure

1. Navigate to the [core infrastructure repository](https://github.com/trade-tariff/trade-tariff-platform-aws-terraform/) on GitHub.
2. Select the **Actions** tab.
3. Under **All workflows**, select **Deploy to production**.
4. Select **Run workflow**.
5. Choose the `main` branch, or enter a known working commit hash.
6. Select **Run workflow** again.
7. Monitor the deployment status.

A clean Terraform run will produce the following output:  **Apply complete!**

## Deploying a Service

To deploy a missing, deleted, or failed service using GitHub Actions:

1. Navigate to the service repository on GitHub.
2. Select the **Actions** tab.
3. Under **All workflows**, select **Deploy to production**.
4. Select **Run workflow**.
5. Choose the branch, or enter the known working commit hash.

- **If Unsure, Deploy a Release:**
     1. Navigate to the **Releases** tab
     2. Choose a release (look for the 7-character commit hash)
     3. Enter this hash into the box labeled **"The git ref to deploy"**

4. Select **Run workflow**.
5. Monitor the deployment status.

## Database Restore

⚠️ **Warning:** AWS credentials are required to perform a database restore. ⚠️

To restore a database manually, create an EC2 instance that you will use as a jump-box to perform the PostgreSQL restore:

## EC2 Instance Setup

1. **Start an AWS session** in the Production account using `TariffPowerUserAccess` or `TariffAdministratorAccess`
2. Navigate to **EC2**
3. Select **Instances**
4. Select **Launch Instances**
5. Choose a name for the instance
   - Pick something simple like `disaster-recovery` or similar
6. Under **Application and OS Images**, the default of Amazon Linux and 64-bit should be selected
7. Under **Instance type**, use the pre-selected instance type
8. Under **Key pair**, select **Create new key pair**
   - Enter a simple name for the key pair
   - Leave the other options unchanged from their defaults
   - Select **Create key pair**. It will be downloaded to your computer
     - **Keep this key pair safe**. You will need it to complete the database restore
9. Select the key pair you just created
10. Under **Network settings**, select **Edit**
11. Change the VPC to deploy the instance in the `trade-tariff-production-vpc`
12. Change the Subnet to use a public subnet
13. Change **Auto-assign public IP** to **Enable**
14. Under **Firewall (security groups)**, ensure **Create security group** is selected
    - The name and description can be left unchanged
    - The launch wizard will pre-populate a rule for SSH access. Leave this unchanged
    - Select **Add security group rule**
    - Under **Type**, select **PostgreSQL**
    - Under **Source type**, select **Custom**
    - Under **Source**, select `trade-tariff-be-rd-production`
15. Scroll to the bottom of the page. Select **Launch instance**

## Database Security Group Configuration

16. **Configure database security group** to allow the EC2 instance access:
    - On the EC2 page, select **Security Groups**
    - Search for `trade-tariff-be-rd-production`. Select the security group
    - Under **Actions**, select **Edit inbound rules**
    - Scroll to the bottom of the list. Select **Add rule**
    - Under **Type**, select **PostgreSQL**
    - Under **Source**, enter `10.0.0.0/8`
    - Under **Description**, enter `Disaster Recovery`
    - Select **Save rules**

## Connect to EC2 Instance

17. Navigate back to **Instances**
18. Select the ID of the instance on the Instances page
19. Check **Instance state**; it should be **Running**
20. Select **Connect**
    - **To connect using EC2 Instance Connect in the browser:**
      - Select **EC2 Instance Connect**
      - Select **Connect**
    - **To connect using the terminal on your machine**, select **SSH client**
      - Follow the steps on this page to connect to the EC2 instance

## Database Restore Process

21. With the terminal window connected to the EC2 instance, copy and run the following command sequence:

    ```bash
    sudo yum update -y && sudo yum install postgresql15 -y
    **Obtain database dump URL with credentials**
    wget https://[username]:[password]@dumps.trade-tariff.service.gov.uk/tariff-merged-production.sql.gz
    gzip -dv tariff-merged-production.sql.gz
    ```

22. **Obtain database connection string** from AWS Secrets Manager:
    - In a new browser tab, navigate to **AWS Secrets Manager**
    - Search for `aurora-postgres-rw-connection-string`
    - Select the secret
    - Under **Secret value**, select **Retrieve secret value**
    - Copy this value

23. **In the terminal of the EC2 instance**, run the following command sequence:

    ```bash
    export DATABASE_URL=<paste_the_copied_secret_value_here>
    psql "${DATABASE_URL}" < tariff-merged-production.sql
    ```

24. Monitor the database restore process

## Completion and Cleanup

25. Once the database restore is complete, disconnect from the EC2 instance
26. **Clean up after the disaster recovery process**:
    - Stop the EC2 instance: select **Instance state**, select **Stop instance**, then select **Stop**
    - Navigate back to the security group `trade-tariff-be-rd-production`
    - Under **Actions**, select **Edit inbound rules**
    - Find the rule with the description **Disaster Recovery** that you created earlier
    - Select **Delete**
