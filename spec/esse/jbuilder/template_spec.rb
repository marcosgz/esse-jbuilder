# frozen_string_literal: true

require "spec_helper"

RSpec.describe Esse::Jbuilder::Template do
  describe ".call" do
    it "renders jbuilder using block" do
      attrs = described_class.call(name: "test") do |json|
        json.query do
          json.match do
            json.set! "name", json.__assigns.fetch(:name)
          end
        end
      end
      expect(attrs).to eq(
        "query" => {
          "match" => {
            "name" => "test"
          }
        }
      )
    end

    it "renders jbuilder using view with real filename" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      attrs = described_class.call("cities/index.json.jbuilder", name: "test")
      expect(attrs).to eq(
        "query" => {
          "match" => {
            "name" => "test"
          }
        }
      )
    end

    it "renders jbuilder using view with filename without extension" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      attrs = described_class.call("cities/index", name: "test")
      expect(attrs).to eq(
        "query" => {
          "match" => {
            "name" => "test"
          }
        }
      )
    end

    it "does not implement partials" do
      Esse.config.search_view_path = "spec/fixtures/searches"

      expect {
        described_class.call(name: "test") do |json|
          json.query do
            json.partial! "shared/nested_query", locals: {path: "states", field: "name", value: json.__assign(:name)}
          end
        end
      }.to raise_error(NotImplementedError)
    end
  end
end
