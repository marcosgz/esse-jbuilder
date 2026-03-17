# frozen_string_literal: true

module Esse
  module Jbuilder
    class SearchRequestView < ::ActionView::Base
      # Cache the LookupContext at the class level to avoid creating a new one
      # per template render. LookupContext initializes file system resolvers,
      # path sets, and detail hashes — expensive objects that are stateless
      # relative to template assigns. Reusing it eliminates ~15K+ short-lived
      # object graphs per minute under production traffic, reducing heap
      # fragmentation that causes RSS growth over time.
      def self.lookup_context
        @lookup_context ||= ::ActionView::LookupContext.new(Esse.config.search_view_path)
      end

      def initialize(assings = {})
        super(self.class.lookup_context, assings, nil)
      end

      def compiled_method_container
        self.class
      end
    end
  end
end
