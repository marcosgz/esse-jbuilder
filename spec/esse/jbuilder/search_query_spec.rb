# frozen_string_literal: true

require "spec_helper"

RSpec.describe Esse::Jbuilder::SearchQuery do
  before do
    stub_esse_index(:cities)
  end

  describe "Search query on Index" do
    it "continues to work as before using :q term" do
      query = CitiesIndex.search("*", size: 10, from: 0)
      expect(query.definition).to eq(
        index: "cities",
        q: "*",
        size: 10,
        from: 0
      )
    end

    it "continues to work as before using :body term" do
      query = CitiesIndex.search(body: {query: {match_all: {}}}, size: 10, from: 0)
      expect(query.definition).to eq(
        index: "cities",
        body: {query: {match_all: {}}},
        size: 10,
        from: 0
      )
    end

    it "appends :body term with block" do
      query = CitiesIndex.search do |json|
        json.query do
          json.set! :match_all, {}
        end
      end
      expect(query.definition).to eq(
        index: "cities",
        body: {
          query: {match_all: {}}
        }
      )
    end

    it "overrides :body term with block" do
      query = CitiesIndex.search(size: 10, from: 0) do |json|
        json.query do
          json.set! :match_all, {}
        end
      end
      expect(query.definition).to eq(
        index: "cities",
        body: {
          query: {match_all: {}},
          size: 10,
          from: 0
        }
      )
    end

    context "with rails available", rails: :yes do
      it "renders jbuilder template" do
        query = CitiesIndex.search do |json|
          json.query do
            json.set! :match_all, {}
          end
          json.aggs do
            json.set! :group_by_state do
              json.terms do
                json.field "state"
              end
            end
          end
        end
        expect(query.definition).to eq(
          index: "cities",
          body: {
            query: {match_all: {}},
            aggs: {
              group_by_state: {
                terms: {
                  field: "state"
                }
              }
            }
          }
        )
      end

      it "loads jbuilder partials from Esse.config.search_view_path" do
        Esse.config.search_view_path = "spec/fixtures/searches"
        query = CitiesIndex.search do |json|
          json.query do
            json.partial! "shared/nested_query", locals: {path: "states", field: "abbr", value: "CA"}
          end
        end
        expect(query.definition).to eq(
          index: "cities",
          body: {
            query: {
              nested: {
                path: "states",
                query: {
                  match: {
                    "states.abbr": "CA"
                  }
                }
              }
            }
          }
        )
      end

      it "raises error if partial is not found" do
        Esse.config.search_view_path = "spec/fixtures/searches"
        expect {
          CitiesIndex.search do |json|
            json.query do
              json.partial! "shared/unknown_partial"
            end
          end
        }.to raise_error(ActionView::MissingTemplate)
      end
    end
  end
end
