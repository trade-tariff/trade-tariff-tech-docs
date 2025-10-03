---
owner_slack: "#trade-tariff-infrastructure"
title: Recover RDS Database via AWS Console
section: Backups
layout: manual_layout
parent: "/manual.html"
---

This playbook provides step-by-step instructions for recovering a **production RDS database** in the event of an incident, using the **AWS Console**.
It complements the [Disaster Recovery Runbook](how-to-disaster-recovery.html) and [Restore RDS Database via AWS CLI](how-to-backup-and-restore-in-aws-rds.html).

## When to Use This Playbook

- Database instability due to failed upgrades or corruption
- Service outages linked to RDS issues
- When CLI access is unavailable or time-sensitive manual recovery is preferred

## Prerequisites

- IAM access to AWS Console with permissions for **RDS, EC2, CloudWatch, and Secrets Manager**
- Access to the **Slack incident triage channel**

## Recovery Steps via AWS Console

### 1. Assess DB Health

1. Navigate to **RDS > Databases**.
2. Locate the affected DB instance.
3. Check **Logs & Events** and **Monitoring**.
4. If the DB is degraded or unresponsive, proceed to restore.

### 2. Attempt Cold Reboot

1. Select the DB → **Actions > Reboot**.
2. Wait and reassess DB health.

### 3. Restore from Snapshot

1. Navigate to **RDS > Snapshots**.
2. Select the **latest snapshot** → **Restore Snapshot**.
3. Configure the restore:
   - New DB identifier
   - Same **VPC, subnet, security group**
   - Parameter and option groups
4. Launch the instance.

### 4. Update Traffic Routing

1. Update **ECS task definition** or environment variables.
2. Redeploy the service.
3. Update **DNS** or **Secrets Manager** if applicable.

### 5. Validate Recovery

1. Run **smoke tests**.
2. Confirm **service stability**.
3. Notify stakeholders.

## Post-Recovery Actions

- Tag the recovered DB.
- Delete broken DB instance (after confirmation).
- Document **timeline and actions** in the incident report.
- Create follow-up tickets for **RCA and improvements**.
