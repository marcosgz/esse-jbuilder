# frozen_string_literal: true

require "esse"
require "action_view"
require "active_support"
require "jbuilder"

require_relative "jbuilder/version"
require_relative "jbuilder/config"
require_relative "jbuilder/template"
require_relative "jbuilder/search_query"

if defined?(::Rails)
  require_relative "jbuilder/view_template"
end

Esse::Config.__send__ :include, Esse::Jbuilder::Config
Esse::Search::Query.prepend Esse::Jbuilder::SearchQuery::InstanceMethods
