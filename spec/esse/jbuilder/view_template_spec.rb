# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Esse::Jbuilder::ViewTemplate" do
  describe ".call", rails: :yes do
    let(:expected_json) do
      {
        query: {
          match: {
            name: "test"
          }
        },
        aggregations: {
          abbreviations: {
            terms: {
              field: "state_abbr"
            }
          }
        }
      }
    end

    before do
      require "esse/jbuilder/view_template"
      Esse::Jbuilder::ViewTemplate.symbolize_keys = true
    end

    it "renders jbuilder template using view relative path" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      actual = Esse::Jbuilder::ViewTemplate.call("states/index", name: "test")
      expect(actual).to eq(expected_json)
    end
  end
end
