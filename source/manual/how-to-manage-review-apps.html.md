---
owner_slack: "#ott-core"
title: Manage preview apps
section: Applications
layout: manual_layout
parent: "/manual.html"
---

You can use preview apps to test changes in isolated environments. These apps are automatically created and destroyed based on pull request (PR) events and labels.

## Where preview environments run

Preview apps are deployed to virtual machines in **AWS Lightsail**. Each environment is created per pull request and managed using [Preevy](https://preevy.dev/).

Preevy uses an **S3 bucket** to store its profile data. The profile was initialised using `preevy init`, and its location is defined in the GitHub Actions workflows via the `PREEVY_PROFILE_URL` environment variable.

For setup instructions, see [Getting started with Preevy](https://preevy.dev/intro/getting-started).

## Deploy a preview app

Preview apps are deployed automatically when you add the `needs-preview` label to a pull request.

The GitHub Actions workflow:

- Assumes a deployment role using AWS Identity and Access Management (IAM)
- Checks out the code
- Fetches secrets from AWS Secrets Manager
- Starts the preview app using the `preevy up` command

To deploy manually:

1. Add the `needs-preview` label to the PR.
2. Wait for the **Preview App Up** workflow to complete.
3. The URL for the preview app will appear in the pull request.

## Destroy a preview app

Preview apps are automatically destroyed when:

- The PR is closed
- The `needs-preview` label is removed

The **Preview App Down** workflow uses the `preevy down` command to destroy the environment.

You can also run the **Nightly Preview Cleanup** job to destroy stale or orphaned environments.

## Clean up preview environments

The cleanup workflow runs every night, or you can trigger it manually from the Actions tab.

It:

- Queries running preview environments via the Preevy CLI and cloud provider (AWS Lightsail)
- Destroys environments that don’t have the exclusion word `keep` in it's branch name
- Removes the `needs-preview` label from any matching PRs
- Sends a Slack notification to the `#deployments` channel summarizing the cleanup results, including:
  - Whether it was a dry run
  - The run mode
  - Which environments were destroyed

You can also trigger the workflow manually with `dry_run=true` to check what would be destroyed.

## Configure environment variables

Secrets and environment variables are handled in three places:

- **GitHub Actions `env:` blocks** define shared configuration like `AWS_REGION` and `PREEVY_PROFILE_URL`
- **AWS Secrets Manager** stores sensitive values like SMTP credentials or API keys. These secrets are fetched during the workflow run and added to the environment.
- **Docker Compose environment** injects variables into the containers. Some of these values are hardcoded directly in the compose.yml file (for example, RAILS_ENV=production), while others reference environment variables fetched from AWS Secrets Manager (for example, ${SMTP_USERNAME} and ${SMTP_PASSWORD}).

Secrets are retrieved with:

```bash
aws secretsmanager get-secret-value \
  --secret-id "${{ env.SECRET_NAME }}" \
  --query "SecretString" \
  --output text \
  | jq -r 'to_entries[] | "\(.key)=\(.value)"' >> "$GITHUB_ENV"

```

## Debug and troubleshooting

You can debug preview environments by connecting to the underlying virtual machine, inspecting containers, or viewing logs.

### Connect to the preview environment

1. List active environments: ```preevy ls```

2. SSH into the environment: ```preevy ssh <environment-name>```

3. Once in the virtual machine, list running containers: ```docker ps```

4. Open a shell in the container: ```docker exec -it frontend /bin/sh```

### View logs

To investigate runtime issues, view logs from the container:

```preevy logs frontend --driver=lightsail --follow```

### More tools

For additional commands and options, see the [Preevy CLI reference](https://preevy.dev/cli-reference/).
