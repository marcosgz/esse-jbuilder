# frozen_string_literal: true

require "active_support/concern"

module Hooks
  module Rails
    extend ActiveSupport::Concern

    included do
      around do |example|
        if example.metadata[:rails]
          begin
            require "rails"
            ActionView::Template.register_template_handler :jbuilder, ::JbuilderHandler
          rescue LoadError
            skip "Rails is not available"
          end
          example.run if defined?(::Rails)
        else
          example.run
        end
      end
    end
  end
end
