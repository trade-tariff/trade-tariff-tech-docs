---
owner_slack: "#trade-tariff-infrastructure"
title: Manage the management account user
section: Deployment
layout: manual_layout
parent: "/manual.html"
---

This document describes the [management account][management-account] `terraform` user.

Scope of user (at the time of writing):

- Manage the aws accounts and roles with terraform in [accounts][accounts] repo

Prerequisites for managing this user:

- Ask someone in [#trade-tariff-infrastructure][trade-tariff-infrastructure] slack channel to create user for you in the [accounts][accounts] repo.
- You'll need to be the `platform` type of user which will give you access to the management account (see [users.yaml][users.yaml]).
- Navigate to the [start][start] page
- Pick the management account
- Navigate to IAM
- Manage the `terraform` user inside of IAM

[management-account]: https://d-9c677042e2.awsapps.com/start/#/console?account_id=036807458659&role_name=TariffAdministratorAccess
[accounts]: https://github.com/trade-tariff/trade-tariff-platform-terraform-aws-accounts
[users.yaml]: https://github.com/trade-tariff/trade-tariff-platform-terraform-aws-accounts/blob/main/users.yaml
[start]: https://d-9c677042e2.awsapps.com/start/#/?tab=accounts
[trade-tariff-infrastructure]: https://trade-tariff.slack.com/archives/C042HGJBHK8
