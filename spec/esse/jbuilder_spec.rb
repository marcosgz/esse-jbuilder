# frozen_string_literal: true

require "spec_helper"

RSpec.describe Esse::Jbuilder do
  before do
    stub_esse_index(:cities)
  end

  it "has a version number" do
    expect(Esse::Jbuilder::VERSION).not_to be_nil
  end
end
