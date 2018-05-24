require 'forwardable'

module Kinda
  module Core
    module Forwardable
      ClassMethods = inheritable_extend do
        include ::Forwardable

        # Add a nice way to specify a different method for the accessor:
        # delegate :remove => [:book, :delete]
        # delegate [:add, :remove] => [:book, :<<, :delete]
        def instance_delegate(hash)
          hash.each do |delegate_methods, accessor|
            accessor_methods = [*accessor]
            accessor_object = accessor_methods.shift
            [*delegate_methods].each do |delegate_method|
              accessor_method = accessor_methods.shift || delegate_method
              def_instance_delegator(accessor_object, accessor_method, delegate_method)
            end
          end
        end
        
        alias_method :delegate, :instance_delegate

        # Create both reader and writer delegate
        # Same usage than the simple "delegate" method except the following form
        # in case the getter and setter symbols are different:
        # delegate_attr :title => [:book, [:read_title, :write_title]]
        def delegate_attr_accessor(hash, kind=(:accessor), with_filter=false, &block)
          hash.each do |delegate_methods, accessor|
            accessor_methods = [*accessor]
            accessor_object = accessor_methods.shift
            [*delegate_methods].each do |delegate_method|
              accessor_method = accessor_methods.shift || delegate_method
              accessor_getter, accessor_setter = case kind
              when :accessor
                getter, setter = [*accessor_method]
                setter ||= getter
                [getter, setter]
              when :reader
                [accessor_method, nil]
              when :writer
                [nil, accessor_method]
              end
              if accessor_getter
                __attr_reader__({ delegate_method => [accessor_object, accessor_getter] },
                  with_filter, &block)
              end
              if accessor_setter
                __attr_writer__({ delegate_method => [accessor_object, accessor_setter] },
                  with_filter, &block)
              end
            end
          end
        end
      
        alias_method :delegate_attr, :delegate_attr_accessor

        def delegate_attr_accessor_with_filter(hash, &block)
          delegate_attr_accessor(hash, :accessor, true, &block)
        end

        alias_method :delegate_attr_with_filter, :delegate_attr_accessor_with_filter

        def delegate_attr_reader(hash, &block)
          delegate_attr_accessor(hash, :reader, false, &block)
        end

        def delegate_attr_reader_with_filter(hash, &block)
          delegate_attr_accessor(hash, :reader, true, &block)
        end

        def delegate_attr_writer(hash, &block)
          delegate_attr_accessor(hash, :writer, false, &block)
        end

        def delegate_attr_writer_with_filter(hash, &block)
          delegate_attr_accessor(hash, :writer, true, &block)
        end
      end

      delegate_to_class ClassMethods.public_instance_methods
    end
  end
end