---
title: How to Add and Run Accessibility Tests with Yarn
description: A guide to running accessibility tests using Playwright and axe-core with Yarn, and viewing the HTML report.
---

# How to Add and Run Accessibility Tests with Yarn

This guide explains how to run accessibility tests in your project using **Playwright** and **axe-core**, with **Yarn** as your package manager. It focuses on generating and viewing the HTML report.

---

## ✅ Features

- Automated accessibility checks using Playwright and axe-core
- HTML report generation with issue severity and guidance
- Report stored in the `dist/` directory for easy viewing

---

## 🧪 Running Accessibility Tests Locally

1. **Install dependencies**:
   ```bash
   yarn install

  **install Playwright browsers**

   yarn playwright install 

   **install Axe-core**
   yarn add @axe-core/playwright

   ```

2. **Run all accessibility tests**:

 ```bash
   yarn run axxy
   ```

This command runs all configured accessibility tests and generates a single HTML report.

3. **Run tests in headed mode (optional)**:
If you want to see the browser while tests run (for debugging or visual verification):


 ```bash
  yarn run axxy --headed
   ```

Or to run your specific accessibility script in headed mode (if accessibility.spec.js is the main file):

bash
yarn playwright test spec/javascript/accessibility/accessibility.spec.js --headed


4. **Run a single test file (optional)**:
To run just one test (e.g. only login page):

```bash
yarn playwright test -g "Duty Calculator" --headed
 ```

5. **To open last HTML report run**:

 ```
  yarn playwright show-report
  ```

6. **View the report**:  
   Open the generated HTML report:
   
   ```
   dist/accessibility-report.html
   ```

---

## 📊 About the Accessibility Report

The HTML report includes:
- Total violations on each tested page
- Grouping by severity:
  - 🔴 Critical
  - 🟠 Serious
  - 🟡 Moderate
  - 🟢 Minor
- For each issue:
  - Short description
  - Link to relevant axe-core documentation
  - HTML snippet of the problematic element
  - CSS selector for locating it in your codebase

---

## 📁 File Structure

project-root/
├── dist/
│   └── accessibility-report.html        # Human-readable HTML report
│
├── spec/
│   └── javascript/
│       └── accessibility/
│           ├── Pages/
│           │   └── loginPage.js         # Page object for login page
│           │
│           ├── utils/
│           │   └── generate-html-report.js  # Script to build the HTML report
│           │
│           ├── accessibility.spec.js    # Main accessibility test spec
│           └── Config.json              # Configuration file for accessibility tests



> Reports are regenerated with every test run. You may choose to ignore `dist/accessibility-report.html` using `.gitignore` if not committing it.
