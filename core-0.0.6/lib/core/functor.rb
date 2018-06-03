module Kinda
  module Core
    # Thomas Sawyer's Functor Class slightly modified for Ruby 1.9
    # http://facets.rubyforge.org/apidoc/api/core/classes/Functor.html
    class Functor < BasicObject
      def initialize(&proc)
        @proc = proc
      end

      def to_proc
        @proc
      end

      def method_missing(method_name, *args, &block)
        @proc.call(method_name, *args, &block)
      end
    end
  end
end