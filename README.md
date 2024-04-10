# OTT Developer Docs

You can find the developer docs deployed, here:

- [production]
- [staging]
- [development]

This is a static site generated with Middleman, using [alphagov/tech-docs-template](https://github.com/alphagov/tech-docs-template).

Some of the files (like the CSS, javascripts and layouts) are managed in the template and are not supposed to be modified here. Any project-specific
Ruby code needs to go into `/app`.

## Build the app locally

```sh
bundle install
```

## Run the tests locally

```sh
make test
```

## Run the app locally

```sh
SKIP_PROXY_PAGES=true make start
```

## Proxy pages

The live docs site includes pages from other trade-tariff GitHub repositories. To test this locally, omit `SKIP_PROXY_PAGES=true` from the command above.

The app downloads these "proxy pages" at startup and this can cause GitHub to rate limit your requests. You can pass a valid GitHub API token to the app to help avoid this:

1. [Create a GitHub token](https://github.com/settings/tokens/new). The token doesn't need any scopes.

1. Store the token in a `.env` file:

```sh
export GITHUB_TOKEN=somethingsomething
```

1. Start the application:

```sh
make start
```

## Update to the latest Tech Docs template

```sh
make update-tech-docs
```

## Deployment

We host OTT Developer Docs as a static site in S3. The GitHub Actions workflows [development], [staging] and [production] updates the site automatically:

- when a PR is opened (releases to development)
- when a PR is merged (releases to development, staging and production - in order)
- on an hourly schedule, to pick up changes to docs included from other repos

### Build the static site locally

```sh
make build
```

### Run the static site locally

```sh
make
```

This will create a `build` directory containing a set of HTML files.

## Licence

[MIT License](LICENCE)


[development]: https://docs.dev.trade-tariff.service.gov.uk/
[staging]: https://docs.staging.trade-tariff.service.gov.uk/
[production]: https://docs.trade-tariff.service.gov.uk/
