---
owner_slack: "#ott-core"
title: Update TO_EMAILS (distribution list) for electronic tariff file
section: Electronic Tariff File
layout: manual_layout
parent: "/manual.html"
important: true
---

## Update TO_EMAILS for electronic tariff file

The `TO_EMAILS` value is a distribution list used to send email notifications when electronic tariff file (ETF) changes occur.

This value is stored in **AWS Secrets Manager** under the secret name: `electronic-tariff-file-configuration` in the **Production** environment.

## How to Update

Only team members with Production access to AWS Secrets Manager can update this value.

To update `TO_EMAILS`:

1. Back up the current list of recipients by checking a previously sent ETF update email.
2. Contact a team member who has access to production secrets in AWS Secrets Manager.
3. Provide them with the updated list of email addresses.
4. Ask them to update the `TO_EMAILS` field in the `electronic-tariff-file-configuration` secret.

## ✅ Notes

- Ensure all email addresses are valid and separated according to the expected format (e.g., comma-separated).
- Confirm the update has been applied correctly by verifying the secret value or coordinating with the person who made the change.
