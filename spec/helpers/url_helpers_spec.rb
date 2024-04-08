require "spec_helper"
require_relative "../../helpers/url_helpers"

RSpec.describe UrlHelpers do
  let(:helper) { Class.new { extend UrlHelpers } }

  describe "#slack_url" do
    it "returns the URL to open a channel in GDS Slack" do
      channel_name = "#general"
      expect(helper.slack_url(channel_name)).to eq("https://future-borders.slack.com/channels/general")
    end
  end
end
