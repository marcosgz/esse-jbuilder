# frozen_string_literal: true

module Esse
  module Jbuilder
    class WithAssigns < ::Jbuilder
      attr_reader :__assigns

      def initialize(options = {})
        @__assigns = options.delete(:assigns) || {}
        super(options)
      end

      def __assign(key)
        __assigns[key]
      end

      def partial!(view_filename, **assigns)
        raise ::NotImplementedError, "Partial rendering is not supported. Consider using Esse::Jbuilder::ViewTemplate.call instead."
      end
    end

    class Template
      attr_reader :view_filename, :assigns

      def self.call(view_filename = nil, **assigns, &block)
        new(view_filename, **assigns).to_hash(&block)
      end

      def initialize(view_filename = nil, **assigns)
        @view_filename = view_filename
        @assigns = assigns
      end

      def to_hash(&block)
        func = block || begin
          raise ArgumentError, "Missing view or block" unless view_filename || block
          fragments = view_filename.split("/")
          filename = fragments.pop
          filename = "#{filename}.json.jbuilder" unless filename.end_with?(".json.jbuilder")
          rel_path = fragments.join("/")

          ->(json) {
            json.instance_eval(File.read(Esse.config.search_view_path.join("#{rel_path}/#{filename}").to_s), view_filename, 1)
          }
        end

        WithAssigns.new(assigns: assigns, &func).attributes!
      end
    end
  end
end
