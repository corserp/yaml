module Kinda
  module Core
    module ModuleExtension
      def self.included(klass)
        klass.alias_method_chain :append_features, :inheritable_extensions
      end

      def alias_method_chain(target, feature)
        # Strip out punctuation on predicates or bang methods since
        # e.g. target?_without_feature is not a valid method name.
        aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
        yield(aliased_target, punctuation) if block_given?

        with_method, without_method =
          "#{aliased_target}_with_#{feature}#{punctuation}",
          "#{aliased_target}_without_#{feature}#{punctuation}"

        alias_method without_method, target
        alias_method target, with_method

        case
          when public_method_defined?(without_method)
            public target
          when protected_method_defined?(without_method)
            protected target
          when private_method_defined?(without_method)
            private target
        end
      end

      def container
        space = name[0...(name.rindex( '::' ) || 0)]
        space.empty? ? Object : eval(space)
      end

      def extensions
        singleton_class.ancestors.take_while { |mod| !mod.is_a?(Class) }
      end

      def inheritable_extend(*mods, &block)
        if block
          mod = Module.new
          mod.extend extensions
          mod.module_eval(&block)
          mods << mod
        end
        extend *mods
        (@inheritable_extensions ||= []).unshift(*mods.reverse).uniq!
        mod
      end

      def append_features_with_inheritable_extensions(target)
        append_features_without_inheritable_extensions(target)
        if @inheritable_extensions
          target.extend *@inheritable_extensions
          target.inheritable_extend *@inheritable_extensions.reverse
        end
      end

      # delegate_to_class :singleton_method_added => :method_added
      # delegate_to_class [:attr_reader, :attr_writer]
      # delegate_to_class ClassMethods.instance_methods
      def delegate_to_class(*sources)
        sources, target = sources.first.first if sources.first.is_a?(Hash)
        [*sources].flatten.each do |source|
          define_method(source) do |*args, &block|
            singleton_class_send(target || source, *args, &block)
          end
        end
      end

      def self_and_ancestors
        result = ancestors
        result.unshift self unless result.first == self
        result
      end

      def ancestors_without_self
        result = ancestors
        result.first == self ? result.drop(1) : result
      end
      
      def ancestor
        ancestors_without_self.first
      end
    end
  end
end

class Module #:nodoc:
  include Kinda::Core::ModuleExtension
end

