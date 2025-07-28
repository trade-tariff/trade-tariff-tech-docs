---
owner_slack: "#ott-core"
title: Introduction to Playwright in Trade Tariff
section: Testing
type: learn
layout: manual_layout
parent: "/manual.html"
---

## What is Playwright?

[Playwright](https://playwright.dev/) is a Node.js library used for end-to-end testing. It enables automated browser testing across Chromium, Firefox, and WebKit. In Trade Tariff projects, Playwright is used to validate key user journeys and ensure accessibility compliance across different environments.

## Why We Use Playwright

Playwright enables us to:

- ✅ Automate **end-to-end tests** for critical user flows
- ✅ Run **accessibility checks** using Axe integration
- ✅ Validate functionality across **multiple environments** (development, staging, production)
- ✅ Ensure cross-browser compatibility and stability of our services

Playwright tests give developers fast, repeatable confidence that user-facing functionality works as expected.

## Where Playwright Is Used

Playwright is implemented in **three** key places across Trade Tariff services:

1. **[trade-tariff-e2e-tests](https://github.com/trade-tariff/trade-tariff-e2e-tests)**
   - Validates end-to-end user journeys in the **Online Trade Tariff** (OTT) service.
   - Covers questions like: _What am I trading?_ and _What measures apply to me?_

2. **[trade-tariff-frontend](https://github.com/trade-tariff/trade-tariff-frontend)**
   - Used for **accessibility testing** using [axe-playwright](https://www.npmjs.com/package/axe-playwright).
   - Ensures compliance with WCAG standards on key pages and components.

3. **[trade-tariff-fpo-dev-hub-e2e](https://github.com/trade-tariff/trade-tariff-fpo-dev-hub-e2e)**
   - Contains E2E tests for the **FPO Developer Hub**.
   - Ensures flows specific to internal or external FPO users are working as expected.

Each of these test suites has its own README file with instructions on how to install, run, and debug tests.

## Who to Contact

For help extending or maintaining Playwright test suites, you can reach out to:

- **Sandya** – Initial implementation and setup
- **Will Fish** – Development and infrastructure support
- **Neil Middleton** – Testing strategy and codebase guidance

Or ask in the **#ott-core** Slack channel.

## Related Documentation

- [Why Accessibility Testing Matters](/manual/accessibility-testing.html)
- [How to Run Accessibility Tests](/manual/how-to-add-and-run-accessibility-tests.html)
