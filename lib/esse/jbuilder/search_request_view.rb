# frozen_string_literal: true

module Esse
  module Jbuilder
    class SearchRequestView < ::ActionView::Base
      # Isolate compiled template methods in a dedicated module instead of
      # accumulating them directly on the class. This prevents unbounded
      # method growth on SearchRequestView over the lifetime of the process.
      module CompiledTemplates
      end
      include CompiledTemplates

      def initialize(assigns = {})
        super(self.class.lookup_context, assigns, nil)
      end

      def compiled_method_container
        CompiledTemplates
      end

      # Returns a cached LookupContext, automatically invalidated when
      # Esse.config.search_view_path changes.
      def self.lookup_context
        current_path = Esse.config.search_view_path
        if @lookup_context_path != current_path
          @lookup_context_path = current_path
          @lookup_context = ::ActionView::LookupContext.new(current_path)
        end
        @lookup_context
      end

      # Clears the cached LookupContext and all compiled template methods.
      # Useful for development/testing when templates or paths change.
      def self.reset!
        @lookup_context = nil
        @lookup_context_path = nil
        CompiledTemplates.instance_methods.each do |method_name|
          CompiledTemplates.remove_method(method_name)
        end
      end
    end
  end
end
