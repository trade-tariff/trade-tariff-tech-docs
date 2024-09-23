---
owner_slack: "#trade-tariff-infrastructure"
title: Rollback trained models
section: Deployment
layout: manual_layout
parent: "/manual.html"
---

This document describes how to rollback training models that have been deployed with Serverless to
our AWS environments.

## Rollback process

1. Identify the model you want to rollback to. This could be the previous model or a specific version of the model.
2. Adjust the [search-config.toml][search-config] file to point to the model you want to rollback to.
3. Open a PR with the changes to the `search-config.toml` file.
4. Once the PR is merged, the changes will be deployed to the `fpo-search` environment.

### Identifying the model to rollback to

Models have iterations on versions and the latest iteration is the one that will be actively deployed today.

Inactive model versions (e.g. previous iterations/those not in an active development branch) are stored in the model s3 bucket.

#### Easiest solution

Assuming you know the code that introduced the failure you can checkout the code history of the [search-config.toml][search-config] file and see what model version was being used at that time.

The model version prior is typically going to be the version you want.

#### List recent iterations of models

In the [FPO search lambda][fpo-search-lambda-repo] repository, run the following command to list the most recent iterations of the last n models:

> Note: You will need to have the AWS CLI installed and configured with the correct permissions.

```bash
.circleci/bin/getversions <n>
```

This will output like so:

```bash
1.5.1-6b3c782
1.6.0-262a174
1.7.0-4595f36
```

You can work out what the currently deployed model version is by making a GET request to the healthcheck endpoint:

```bash
curl --silent -X GET https://search.dev.trade-tariff.service.gov.uk/healthcheck -H 'Content-Type: application/json' | jq -r '.model_version'

1.7.0-4595f36
```

You can then review the release notes and benchmarks for these models to know which one you want to rollback to.

[search-config]: https://github.com/trade-tariff/trade-tariff-lambdas-fpo-search/blob/main/search-config.toml
[fpo-search-lambda-repo]: https://github.com/trade-tariff/trade-tariff-lambdas-fpo-search
