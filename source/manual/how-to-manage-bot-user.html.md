---
owner_slack: "#trade-tariff-infrastructure"
title: Manage bot user
section: Deployment
layout: manual_layout
parent: "/manual.html"
---

This document describes how to manage the [trade-tariff-infrastructure-continuity][trade-tariff-infrastructure-continuity]

We have an infrastructure continuity account which has write access via the [trade-tariff-bot-users][trade-tariff-bot-users] group.

Scope of user (at the time of writing):

- checkout modules on behalf of terraform initiailisation and to run the terraform plan and apply commands.
- write commits in the FPO model run to automate model builds

We maintain a private ssh key which is associated with this user in the [trade-tariff organisation secrets][trade-tariff-secrets] that workflows can
use to gain access to the repos in the organisation.

> The user is not a maintainer and if you need additional permissions it is recommended that you use ephemeral credentials using the Github permissions DSL or move to using a PAT (personal access token) in more involved workflows.

Prerequisites for managing this user:

- You will need the email/password for the bot user in the infrastructure continuity account (ask #trade-tariff-infrastructure) for this.

[trade-tariff-infrastructure-continuity]: https://github.com/orgs/trade-tariff/people/trade-tariff-infrastructure-continuity
[trade-tariff-bot-users]: https://github.com/orgs/trade-tariff/teams/trade-tariff-bot-users
[trade-tariff-secrets]: https://github.com/organizations/trade-tariff/settings/secrets/actions
