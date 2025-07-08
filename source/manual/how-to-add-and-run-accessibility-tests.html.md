---
owner_slack: "#ott-core"
title: How to Add and Run Accessibility Tests
section: Testing
layout: manual_layout
parent: "/manual.html"
---

This guide explains how to configure, add, and run accessibility tests using Playwright and axe-core, with Yarn as the package manager. It emphasizes generating and viewing HTML reports for accessibility violations.

---

## Features

- Automated checks with playwright and axe-core
- HTML report generation detailing issue severity and remediation guidance
- Reports stored in the `dist/` directory for review

---

## Configuring Accessibility Tests

To add new pages or paths for testing, update the configuration file located in the `trade-tariff-frontend` repository at [spec/javascript/accessibility/config.json](https://github.com/trade-tariff/trade-tariff-frontend/blob/main/spec/javascript/accessibility/config.json).

The file uses a JSON array of objects with the following structure:

```json
{
  "name": "Quota Search",
  "path": "/quota_search?order_number=052012",
  "threshold": 5
}
```

## Running Accessibility Tests Locally

Install Dependencies

```bash
yarn
yarn playwright install
```

Populate the relevant environment variables in .env

```bash
BASE_URL=https://dev.trade-tariff.service.gov.uk
ADMIN_URL=https://admin.dev.trade-tariff.service.gov.uk
BASIC_PASSWORD=<redacted>
```

Run All Tests with output in a terminal

```bash
yarn run axxy
```

Run All Tests with output shown in a UI

```bash
yarn run axxy --headed
```
