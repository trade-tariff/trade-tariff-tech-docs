---
owner_slack: "#ott-core"
title: Get started developing on the OTT
description: Guide for new developers on OTT
layout: manual_layout
section: Learning GOV.UK
---

> This getting started guide is for new technical staff (for example developers, technical architects) working on OTT.

If you're having trouble with this guide, you can ask your colleagues on the [#ott-core Slack channel][developer-chat].

## Before you start

You will need to know who your tech lead is, as you will need them for some of these steps.

You should have been given a "developer build" laptop with full admin access. To find out, try running `sudo whoami` in your terminal. It should prompt for your local account password and print `root` if you entered your password correctly.

If you don't have admin access to your laptop, file a ticket with the IT helpdesk and copy your line manager.

## 1. Install the Xcode command-line tools

Run the following in your command line to install the Xcode command line tools:

```sh
xcode-select --install
```

## 2. Install the Homebrew package manager

Run the following in your command line to install the [Homebrew package manager](https://brew.sh):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This command works for macOS or Linux.

## 3. Fill out your Slack profile

You should already have access to Slack. If not, please talk with your line manager.

Help others know who you are by [updating your Slack profile's 'title' field](https://slack.com/intl/en-gb/help/articles/204092246-Edit-your-profile). This should include:

- your job role
- the team you're working on
- a photograph

## 4. Set up your GitHub account

1. [Log into your existing GitHub account](https://github.com/login) or [create a new one](https://github.com/signup).
1. [Generate an SSH key][generate-ssh-key].
1. [Add the SSH key to your GitHub account][add-ssh-key].
1. Check that you can access GitHub using the new key:
1. Verify with a team member in slack that you have write access to the repositories and are properly invited to the organisation

```sh
ssh -T git@github.com
```

1. Add your name and email to your git commits. For example:

```sh
git config --global user.email "<your-email-address@example.com>"
git config --global user.name "Friendly Giraffe"
```

[generate-ssh-key]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
[add-ssh-key]: https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

## 5. Set up your AWS IAM user account

1. Open a PR to create yourself an account with [developer permissions][request-aws-user]]
1. Once the PR is approved and merged and the build is run navigate to the [start] page
1. Follow password reset instructions to generate a password for your user
1. [Enable Multi-factor Authentication (MFA)][enable-mfa] for your IAM User.

> <strong>You must specify your email address as the MFA device name.</strong>

![Screenshot of the Add MFA Device dialog in the AWS console](images/aws/assign-mfa-device.png)

[request-aws-user]: https://github.com/trade-tariff/trade-tariff-platform-terraform-aws-accounts
[start]: https://d-9c677042e2.awsapps.com/start/
[enable-mfa]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable_virtual.html#enable-virt-mfa-for-iam-user

## 6. Set up OTT Docker

We use a Docker environment and docker-compose for local development.

To set up Docker you will need too:

1. Install the [docker app](https://docs.docker.com/desktop/install/mac-install/)
2. Install [docker-compose](https://formulae.brew.sh/formula/docker-compose) with Homebrew
3. Copy over the docker-compose.yml file to your home directory
4. In a long-lived terminal window use `docker-compose up` when in the home directory

```yaml
version: "2"
services:
  redis:
    container_name: redis
    image: redis
    ports:
      - 127.0.0.1:6379:6379
    volumes:
      - dev-env-redis-volume:/data
  hmrc-postgres:
    container_name: postgres
    image: postgres:13
    environment:
      - PGDATA=/var/lib/postgresql/data/pgdata
      - POSTGRES_USER=${USER}
      - POSTGRES_PASSWORD=
      - LANG=C.UTF-8
      - POSTGRES_HOST_AUTH_METHOD=trust
    ports:
      - 127.0.0.1:5432:5432
    volumes:
       - hmrc-postgres13:/var/lib/postgresql/data
  hmrc-opensearch:
    container_name: hmrc-opensearch
    image: opensearchproject/opensearch:2
    ports:
      - 127.0.0.1:9200:9200
      - 127.0.0.1:9300:9300
    environment:
      - bootstrap.memory_lock=true
      - discovery.type=single-node
      - "OPENSEARCH_JAVA_OPTS=-Xms500m -Xmx500m"
      - cluster.routing.allocation.disk.threshold_enabled=false
      - plugins.security.disabled=true
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    healthcheck:
      interval: 60s
      retries: 10
      test: curl -s http://localhost:9200/_cluster/health | grep -vq '"status":"red"'
    volumes:
      - hmrc-os:/usr/share/opensearch/data
      - ./config/opensearch/synonyms_all.txt:/usr/share/opensearch/config/synonyms_all.txt:z
      - ./config/opensearch/stemming_exclusions_all.txt:/usr/share/opensearch/config/stemming_exclusions_all.txt:z

volumes:
  dev-env-redis-volume:
    driver: local
  postgres:
    driver: local
  hmrc-postgres:
    driver: local
  hmrc-postgres13:
    driver: local
  hmrc-os:
    driver: local
```

> This is not mandatory but it makes running reproducable services like postgres, redis and opensearch easier.

## 7. Install the ecsexec script

We use [ecs exec](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html) to establish a console to our applications to run one-off tasks.

- Download a copy of the [ecsexec](https://github.com/trade-tariff/trade-tariff-tools/blob/main/bin/ecsexec.sh) script
- Export your environment variables for AWS (including AWS_REGION)
- Follow the instructions in the [README.md](https://github.com/trade-tariff/trade-tariff-tools/tree/main)

## 8. Get Signon accounts

We use a single signon app to control access to an admin application.
We run our own version of this for testing purposes but in production this is hosted by the GDS team

1. Ask in [#ott-core][developer-chat] for access to the [development][development-admin] and [staging][staging-admin] admin apps
2. Ask in [#trade-tariff-infrastructure][infrastructure-chat] for [production][production-admin] access

[development-admin]: https://admin.dev.trade-tariff.service.gov.uk/
[staging-admin]: https://admin.staging.trade-tariff.service.gov.uk/
[production-admin]: https://admin.staging.trade-tariff.service.gov.uk/

## 9. Get familiar with the Release process

Most of our applications release on a two-times-per-week cadence and
are manually gated inside of circle ci.

Developers and devops are responsible for releases and we use a buddy system with a primary
and secondary deployer who are responsible for:

1. Checking any release notes for today's release in the [#ott-core][developer-chat] channel
2. Verifying the regression suites are passing in [#tariffs-regression][regression-chat]
3. Making sure that all applications are released via the circle ci interface

> Failing deploys can be communicated in the [#trade-tariff-infrastructure][infrastructure-chat] slack channel

## 10. Get familiar with the applications we run

You can review all of our application repos in the [repos page](/repos.html).

[regression-chat]: https://future-borders.slack.com/archives/C02T8JXUYE9
[developer-chat]: https://future-borders.slack.com/archives/C01DXUP15M5
[infrastructure-chat]: https://future-borders.slack.com/archives/C042HGJBHK8
