---
owner_slack: "#ott-core"
title: Why Accessibility Testing Matters
section: Testing
type: learn
layout: manual_layout
parent: "/manual.html"
---

## What is Accessibility?

Accessibility ensures digital content is usable by everyone, including individuals with:

- Visual impairments
- Hearing impairments
- Mobility limitations
- Cognitive or neurological conditions

Web accessibility focuses on creating websites that are **perceivable**, **operable**, **understandable**, and **robust** for all users, regardless of ability.

---

## Why Accessibility Testing Matters

### Legal Compliance

Many regions require public sector and government websites to meet accessibility standards, such as WCAG 2.1, the UK Equality Act 2010, and the Public Sector Bodies (Websites and Mobile Applications) Accessibility Regulations.

### Inclusive Design

Testing ensures compatibility with assistive technologies, such as screen readers, keyboard navigation, and voice control, enabling equitable access for all users.

### Enhanced User Experience

Accessible design improves usability for everyone by providing:

- Clear navigation
- High-contrast visuals
- Readable and well-structured content

### Proactive Quality Assurance

Integrating automated accessibility checks into CI/CD pipelines catches issues early, reducing risks and minimizing costly rework.

---

## Common Accessibility Violations and Fixes

To illustrate the practical impact of accessibility testing, here are some common violations, their effects on users, and how fixing them makes a difference:

### 1. Insufficient Color Contrast

- **Violation**: Text or interactive elements with low contrast ratios (e.g., light gray text on a white background).
- **Impact**: Users with low vision, color blindness, or those in bright lighting conditions struggle to read or distinguish elements, leading to frustration or exclusion.
- **Fix**: Ensure a minimum contrast ratio of 4.5:1 for normal text (per WCAG guidelines) by adjusting colors.
- **Benefit**: Improves readability for all users, including those without impairments, and reduces eye strain.

### 2. Missing Alternative Text for Images

- **Violation**: Images without descriptive alt text attributes.
- **Impact**: Screen reader users (e.g., blind individuals) receive no information about the image, missing key context or functionality if the image is interactive.
- **Fix**: Add concise, meaningful alt text that describes the image's purpose or content (e.g., alt="Chart showing quarterly sales growth").
- **Benefit**: Enables full content access for visually impaired users and enhances SEO, as search engines can better index images.

### 3. Non-Keyboard-Accessible Navigation

- **Violation**: Elements like buttons or menus that can only be interacted with via mouse, without proper focus indicators or tab order.
- **Impact**: Users with mobility impairments who rely on keyboards, switches, or voice commands cannot navigate or interact with the site, effectively barring access.
- **Fix**: Implement logical tab order, visible focus states, and ensure all interactive elements are operable via keyboard.
- **Benefit**: Makes the site more efficient for power users who prefer keyboard shortcuts and ensures compliance with operable WCAG principles.

### 4. Videos Without Captions or Transcripts

- **Violation**: Multimedia content lacking synchronized captions or text alternatives.
- **Impact**: Deaf or hard-of-hearing users cannot access audio information, while others in noisy environments or with cognitive processing needs may also struggle.
- **Fix**: Provide accurate captions and optional transcripts for videos.
- **Benefit**: Broadens audience reach, improves comprehension for non-native speakers, and supports multitasking (e.g., reading while watching).

These examples demonstrate how addressing violations not only aids specific user groups but often elevates the overall quality and usability of the product.

---

## How We Test Accessibility

We leverage the following tools:

- **axe-core**: An open-source accessibility testing engine
- **Playwright**: For end-to-end accessibility testing across web pages
- **HTML Reports**: To visualize, debug, and resolve issues efficiently

---

## Resources

- [W3C Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/WAI/WCAG21/quickref/)
- [GOV.UK Accessibility Guidance](https://www.gov.uk/service-manual/helping-people-to-use-your-service)
