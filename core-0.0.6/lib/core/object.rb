module Kinda
  module Core
    module ObjectExtension
      def self.included(klass)
        klass.alias_method_chain :extend, :flexible_arguments
      end

      def object_hexid
        "0x" + ('%.x' % (self.__id__ * 2))
      end

      def singleton_class
        class << self; self; end
      end

      def singleton_class_eval(&block)
        singleton_class.class_eval(&block)
      end

      def singleton_class_send(method_name, *args, &block)
        singleton_class_eval { send(method_name, *args, &block) }
      end

      def to_class
        kind_of?(Module) ? self : singleton_class
      end
      
      alias_method :to_module, :to_class

      def extend_with_flexible_arguments(*modules)
        mods = modules.flatten
        extend_without_flexible_arguments(*mods) unless mods.empty?
      end

      def tap
        return super if block_given?
        Functor.new { |method, *args| self.send(method, *args); self }
      end

      def try(method_name, *args, &block)
        send(method_name, *args, &block) if respond_to?(method_name)
      end

      def receiver
        self
      end

      alias_method :__instance_exec__, :instance_exec

      def parse_arguments(args, *defaults)
        args = args.dup
        options = args.last.is_a?(Hash) ? args.pop : {}
        raise ArgumentError, "Too many arguments (#{args.size} for #{defaults.size})" if
          args.size > defaults.size
        defaults.drop(args.size).each { |default| args << default }
        args << options
      end
    end
  end
end

class Object #:nodoc:
  include Kinda::Core::ObjectExtension
end