# frozen_string_literal: true


module Esse
  module Jbuilder
    module Config
      def self.included(base)
        base.__send__(:include, InstanceMethods)
      end

      module InstanceMethods
        DEFAULT_SEARCH_VIEW_PATH = "app/searches"

        def search_view_path
          @search_view_path ||= Pathname.new(DEFAULT_SEARCH_VIEW_PATH)
        end

        def search_view_path=(path)
          @search_view_path = path.is_a?(String) ? Pathname.new(path) : path
        end
      end
    end
  end
end
