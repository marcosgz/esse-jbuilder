# frozen_string_literal: true

require "spec_helper"

RSpec.describe Esse::Jbuilder::Config do
  it "has a default search_view_path" do
    expect(Esse.config.search_view_path).to eq(Pathname.new("app/searches"))
  end

  it "can be configured" do
    Esse.config.search_view_path = "app/queries"
    expect(Esse.config.search_view_path).to eq(Pathname.new("app/queries"))
  end
end
