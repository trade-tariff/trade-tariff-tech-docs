class ProxyPages
  def self.resources
    repo_docs +
      repo_overviews +
      repo_overviews_json
  end

  def self.repo_docs
    docs = Repos.active_public.map do |repo|
      docs_for_repo = GitHubRepoFetcher.instance.docs(repo.repo_name) || []
      docs_for_repo.map do |page|
        {
          path: page[:path],
          template: "templates/external_doc_template.html",
          frontmatter: {
            title: "#{repo.repo_name}: #{page[:title]}",
            locals: {
              title: "#{repo.repo_name}: #{page[:title]}",
              markdown: page[:markdown],
              repo:,
              relative_path: page[:relative_path],
            },
            data: {
              repo_name: repo.repo_name,
              source_url: page[:source_url],
              latest_commit: page[:latest_commit],
            },
          },
        }
      end
    end

    docs.flatten.compact
  end

  def self.repo_overviews
    Repos.all.map do |repo|
      {
        path: "/repos/#{repo.app_name}.html",
        template: "templates/repo_template.html",
        frontmatter: {
          title: repo.page_title,
          locals: {
            title: repo.page_title,
            description: "Everything about #{repo.app_name} (#{repo.description})",
            repo:,
          },
        },
      }
    end
  end

  def self.repo_overviews_json
    Repos.all.map do |repo|
      {
        path: "/repos/#{repo.repo_name}.json",
        template: "templates/json_response.json",
        frontmatter: {
          locals: {
            payload: repo.api_payload,
          },
        },
      }
    end
  end
end
