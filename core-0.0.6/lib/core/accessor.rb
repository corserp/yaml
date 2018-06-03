module Kinda #:nodoc:
  module Core #:nodoc:
    # Improves the Ruby buit-in accessor methods
    module Accessor
      ClassMethods = inheritable_extend do
        def __attr_reader__(*attributes, with_filter, &block)
          attributes.each do |attribute|
            if attribute.is_a?(Hash)
              attribute, source = attribute.first
            else
              source = "@#{attribute}"
            end
            proc = if with_filter || !block
              Proc.new do |*args|
                return send("#{attribute}=", *args) unless args.empty?
                value = if source[0] == '@'
                   instance_variable_get(source)
                else
                  [*source].inject(self) do |object, symbol|
                    object.send(symbol)
                  end
                end
                block ? instance_exec(value, &block) : value
              end
            else
              block
            end
            send(:define_method, attribute, &proc)
          end
        end
        
        private :__attr_reader__

        # attr_reader(:name, :age, :size)
        # attr_reader(:name => :@name) is the default behaviour but you can use:
        # attr_reader (:name => @the_name) to use a different instance variable
        # attr_reader(:name => :first_name) or even an another attribute.
        # More interesting, you can delegate to another object:
        # attr_reader(:name => [:father, :name])
        # attr_reader(:name => [:mother, :husband, :name])
        def attr_reader(*attributes, &block)
          __attr_reader__(*attributes, false, &block)
        end

        def attr_reader_with_filter(*attributes, &block)
          __attr_reader__(*attributes, true, &block)
        end

        def __attr_writer__(*attributes, with_filter, &block)
          attributes.each do |attribute|
            if attribute.is_a?(Hash)
              attribute, target = attribute.first
            else
              target = "@#{attribute}"
            end
            proc = if with_filter || !block
              Proc.new do |value|
                value = instance_exec(value, &block) if block
                if target[0] == '@'
                  instance_variable_set(target, value)
                else
                  [*target][0..-2].inject(self) do |object, symbol|
                    object.send(symbol)
                  end.send("#{[*target].last}=", value)
                end
              end
            else
              block
            end
            send(:define_method, "#{attribute}=", &proc)
          end
        end
        
        private :__attr_writer__

        def attr_writer(*attributes, &block)
          __attr_writer__(*attributes, false, &block)
        end

        def attr_writer_with_filter(*attributes, &block)
          __attr_writer__(*attributes, true, &block)
        end

        def attr_accessor(*attributes, &block)
          attr_reader(*attributes, &block)
          attr_writer(*attributes, &block)
        end

        def attr_accessor_with_filter(*attributes, &block)
          attr_reader_with_filter(*attributes, &block)
          attr_writer_with_filter(*attributes, &block)
        end
    
        def attr(attribute, writable=false)
          attr_reader(attribute)
          attr_writer(attribute) if writable
        end

        def attr_reader_with_default(attribute, default_value)
          attr_reader_with_filter(attribute) do |value|
            value.nil? ? default_value : value
          end
        end

        def attr_accessor_with_default(attribute, default_value)
          attr_reader_with_default(attribute, default_value)
          attr_writer(attribute)
        end
      end

      delegate_to_class ClassMethods.public_instance_methods
    end
  end
end
