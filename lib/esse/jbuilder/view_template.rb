# frozen_string_literal: true

require "rails"
require "jbuilder/jbuilder_template"

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
      attr_reader :view_filename, :assigns

      def self.call(view_filename, assigns = {})
        new(view_filename, assigns).to_hash
      end

      def initialize(view_filename, assigns = {})
        @view_filename = view_filename
        @assigns = assigns.transform_keys(&:to_sym)
      end

      def to_hash
        lookup_context = ::ActionView::LookupContext.new(Esse.config.search_view_path)
        view = ActionView::Base.new(lookup_context, assigns, nil, %i[json])
        hash = JbuilderTemplate.new(view) do |json|
          json._render_template! view_filename
        end.attributes!
        Esse::HashUtils.deep_transform_keys(hash, &:to_sym)
      end
    end
  end
end
