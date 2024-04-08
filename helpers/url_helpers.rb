module UrlHelpers
  def slack_url(channel_name)
    "https://future-borders.slack.com/channels/#{channel_name.sub('#', '')}"
  end
end
