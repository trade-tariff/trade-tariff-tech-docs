---
owner_slack: "#ott-core"
title: Rollback and Apply Tariff Updates
section: Tariff Updates
layout: manual_layout
parent: "/manual.html"
---

This document describes how to rollback and apply tariff updates. These updates
are applied nightly and are the basis for all data in the OTT.

## Overview

The admin site is available for update management in the development, staging and production environments.

You can review these at the following URLs:

- [Development](https://admin.dev.trade-tariff.service.gov.uk)
- [Staging](https://admin.staging.trade-tariff.service.gov.uk)
- [Production](https://admin.trade-tariff.service.gov.uk)

Typically you'll want to do the following to roll back and roll forward with updates:

1. Identify the update you want to rollback too.
2. Rollback to the update before the date you want to rollback to.
3. Download updates
4. Apply updates

> We keep two database schemas that we might want to rollback. XI (data produced by the Europeans) and UK (data produced by the UK government). The rollback process is the same for both and you can toggle the schema in the nav bar of the admin apps.

View of the updates page

![Tariff Admin Updates Page](images/tariff-updates-page.png)

### Rollback process

1. Identify the update you want to rollback too.
2. Navigate to the update before the date you want to rollback to.
3. Click the rollback button and follow through the onscreen wizard

> Typically you don't want to `keep` the update rows so you can leave this and the
rollback date as the default.

### Download process

The download process is as simple as navigating to the *Updates* nav page and clicking the green download button.

You'll want to wait until all of the updates are downloaded and in `Pending` status before subsequently applying them.

### Apply process

The apply process is as simple as navigating to the *Updates* nav page and clicking the green apply button.

You can review (on the UK tariff) the inserts that got created as a byproduct of the updates by clicking `Review inserts`.
