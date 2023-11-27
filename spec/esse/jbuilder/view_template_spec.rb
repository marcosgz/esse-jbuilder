# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Esse::Jbuilder::ViewTemplate" do
  describe ".call", rails: :yes do
    require "esse/jbuilder/view_template"

    def described_class
      Esse::Jbuilder::ViewTemplate
    end

    let(:expected_json) do
      {
        "query" => {
          "match" => {
            "name" => "test"
          }
        },
        "aggregations" => {
          "abbreviations" => {
            "terms" => {
              "field" => "state_abbr"
            }
          }
        }
      }
    end

    it "renders jbuilder using view with real filename" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      actual = described_class.call("states/index.json.jbuilder", name: "test")
      expect(actual).to eq(expected_json)
    end

    it "renders jbuilder using view with filename without extension" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      actual = described_class.call("states/index", name: "test")
      expect(actual).to eq(expected_json)
    end
  end
end
