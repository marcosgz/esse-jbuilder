# frozen_string_literal: true

require "rails"
require "jbuilder/jbuilder_template"
require_relative "search_request_view"

module Esse
  module Jbuilder
    class JbuilderTemplate < ::JbuilderTemplate
      def _render_template!(path, options = {})
        options[:template] = path
        options[:locals] ||= {}
        options.delete(:partial)
        _render_partial(options)
      end
    end

    class ViewTemplate
      class_attribute :symbolize_keys, default: false

      attr_reader :view_filename, :assigns

      def self.call(view_filename, assigns = {})
        new(view_filename, assigns).to_hash
      end

      def initialize(view_filename, assigns = {})
        @view_filename = view_filename
        @assigns = assigns.transform_keys(&:to_sym)
      end

      def to_hash
        view = Esse::Jbuilder::SearchRequestView.new(assigns)
        hash = JbuilderTemplate.new(view) do |json|
          json._render_template! view_filename
        end.attributes!
        self.class.symbolize_keys ? Esse::HashUtils.deep_transform_keys(hash, &:to_sym) : hash
      end
    end
  end
end
