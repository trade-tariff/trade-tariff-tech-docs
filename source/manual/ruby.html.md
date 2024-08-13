---
owner_slack: "#ott-core"
title: Install ruby
section: Applications
layout: manual_layout
parent: "/manual.html"
---

> We use `asdf` to manage multiple runtime versions. This guide will show you how to install `ruby` with `asdf`.

## Prerequisites

- Mac
- [Homebrew][homebrew]
- curl
- git

## Steps

- Install `asdf` with homebrew
- Install `ruby` with `asdf`
- Enable a global version of `ruby` with `asdf`
- Check your ruby version

### Install `asdf` with homebrew

```sh
brew install asdf
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
```

### Install `ruby` with `asdf`

```sh
# Enable the ruby plugin in asdf
asdf plugin add ruby
# Find a ruby version you want
asdf list-all ruby
# Install the version you want
asdf install ruby 3.0.2
```

### Enable a global version of `ruby` with `asdf`

```sh
# Enable a global version of ruby
asdf global ruby 3.0.2
```

### Check your ruby version

```sh
ruby --version
```

## Project-specific ruby versions

`asdf` offers support for a local file in a specific project to specify the version of ruby to use.

This diminishes the chance of differences between your locally used version of ruby and the version installed
in other environments from causing issues.

This is all configured with `.tool-versions` in the root of each project repoistory

For example, to specify the version of ruby to use in a project, create a `.tool-versions` file in the root of the project repository with the following content:

```sh
asdf local ruby 3.0.2
```

## Project-specific updates to ruby

If you need to update the version of ruby in a project, update the `.tool-versions` file in the root of the project repository with the new version of ruby you want to use.

Everyone that uses `asdf` can then just run `asdf install` in the project repository to install the new version of ruby.

[homebrew]: https://brew.sh/
