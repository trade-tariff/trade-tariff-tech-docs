---
owner_slack: "#ott-core"
title: Update TO_EMAILS (distribution list) for electronic tariff file
section: Electronic Tariff File
layout: manual_layout
parent: "/manual.html"
important: true
---

## Update TO_EMAILS for electronic tariff file

The **TO_EMAILS** is a distribution list used to send tariff updates to which needs to be changed from time to time.<br><br>**IMPORTANT** It cannot be edited and must be deleted and re-created so before attempting this back up the current distribution list from an email already sent. Then follow these steps<br><br>

1. Go to [https://app.circleci.com/settings/organization/github/trade-tariff/contexts](https://app.circleci.com/settings/organization/github/trade-tariff/contexts)

2. Click on the context electronic-tariff-file

3. Remove the env var TO_EMAILS

4. Click on “Add Environment Variable” and add a variable with the same name “TO_EMAILS” and set the value (the list of emails that will receive the notification for the ETF Changes)
