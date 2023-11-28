# frozen_string_literal: true

module Esse
  module Jbuilder
    class SearchRequestView < ::ActionView::Base
      def initialize(assings = {})
        lookup_context = ::ActionView::LookupContext.new(Esse.config.search_view_path)
        super(lookup_context, assings, nil)
      end

      def compiled_method_container
        self.class
      end
    end
  end
end
