# frozen_string_literal: true

module Esse
  module Jbuilder
    module SearchQuery
      module InstanceMethods
        def initialize(transport, *indices, suffix: nil, **definition, &block)
          super(transport, *indices, suffix: suffix, **definition)

          if block
            @definition[:body] ||= {}
            attrs = render_jbuilder_template(&block)
            @definition[:body].merge! Esse::HashUtils.deep_transform_keys(attrs, &:to_sym)
          end
        end

        private

        def render_jbuilder_template(&block)
          if defined?(Rails)
            require_relative "view_template"
            view = Esse::Jbuilder::SearchRequestView.new({})
            ::JbuilderTemplate.new(view, &block).attributes!
          else
            ::Jbuilder.new(&block).attributes!
          end
        end
      end
    end
  end
end
