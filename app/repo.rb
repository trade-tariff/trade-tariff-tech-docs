class Repo
  attr_reader :repo_data

  def initialize(repo_data)
    @repo_data = repo_data
  end

  def api_payload
    {
      app_name:, # beware renaming the key - it's used here: https://github.com/alphagov/seal/blob/36a897b099943713ea14fa2cfe1abff8b25a83a7/lib/team_builder.rb#L97
      team:,
      dependencies_team:,
      shortname:,
      production_hosted_on:,
      links: {
        self: "https://docs.trade-tariff.service.gov.uk/repos/#{app_name}.json",
        html_url:,
        repo_url:,
        sentry_url:,
      },
    }
  end

  def production_hosted_on_eks?
    production_hosted_on == "eks"
  end

  def production_hosted_on_aws?
    false
  end

  def production_hosted_on
    repo_data["production_hosted_on"]
  end

  def is_app?
    !production_hosted_on.nil?
  end

  def html_url
    "https://docs.trade-tariff.service.gov.uk/repos/#{app_name}.html"
  end

  def retired?
    repo_data["retired"]
  end

  def is_gem?
    repo_data["type"] == "Gems"
  end

  def private_repo?
    repo_data["private_repo"]
  end

  def page_title
    type = is_app? ? "Application" : "Repository"
    if retired?
      "#{type}: #{app_name} (retired)"
    else
      "#{type}: #{app_name}"
    end
  end

  def app_name
    repo_data["app_name"] || repo_name
  end

  def repo_name
    repo_data.fetch("repo_name")
  end

  def example_published_pages
    RepoData.publishing_examples[repo_name]
  end

  def example_rendered_pages
    RepoData.rendering_examples[repo_name]
  end

  def management_url
    repo_data["management_url"]
  end

  def repo_url
    repo_data["repo_url"] || "https://github.com/trade-tariff/#{repo_name}"
  end

  def sentry_url
    repo_data["sentry_url"]
  end

  def api_docs_url
    repo_data["api_docs_url"]
  end

  def component_guide_url
    repo_data["component_guide_url"]
  end

  def type
    repo_data.fetch("type")
  end

  def team
    repo_data["team"] || Repos::UNKNOWN
  end

  def dependencies_team
    repo_data
      .fetch("dependencies_team", team)
  end

  def description
    repo_data["description"] || description_from_github
  end

  def production_url
    return if repo_data["production_url"] == false

    repo_data["production_url"] || (type.in?(["Publishing apps", "Supporting apps"]) ? "https://#{repo_name}.publishing.service.gov.uk" : nil)
  end

  def readme
    github_readme
  end

private

  def kibana_url_for(app:, hours: 3, include: %w[level request status message])
    if production_hosted_on_eks?
      "https://kibana.logit.io/s/13d1a0b1-f54f-407b-a4e5-f53ba653fac3/app/discover?security_tenant=global#/?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-#{hours}h,to:now))&_a=(columns:!(#{include.join(',')}),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'filebeat-*',key:kubernetes.labels.app_kubernetes_io%2Fname,negate:!f,params:(query:#{app}),type:phrase),query:(match_phrase:(kubernetes.labels.app_kubernetes_io%2Fname:#{app})))),index:'filebeat-*',interval:auto,query:(language:kuery,query:''),sort:!())"
    end
  end

  def argo_cd_apps
    repo_data["argo_cd_apps"] || [repo_name]
  end

  def shortname
    repo_data["shortname"] || app_name.underscore
  end

  def description_from_github
    github_repo_data["description"]
  end

  def github_repo_data
    return {} if private_repo?

    @github_repo_data ||= GitHubRepoFetcher.instance.repo(repo_name)
  end

  def github_readme
    return nil if private_repo?

    @github_readme ||= GitHubRepoFetcher.instance.readme(repo_name)
  end
end
