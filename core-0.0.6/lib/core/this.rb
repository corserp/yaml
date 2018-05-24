module Kinda
  module Core
    module This
      module ProcExtension
        def call_with_this(this, *args, &block)
          binding_self = binding.eval('self')
          binding_self.push_this(this)
          call(*args, &block)
        ensure
          binding_self.pop_this
        end
      end

      ###

      def call_with_this(proc, *args, &block)
        return unless proc
        binding_self = proc.binding.eval('self')
        raise "Object #{binding_self.inspect} doesn't respond to Kinda::Core::This methods " +
          "(proc=#{proc.inspect})" unless binding_self.respond_to?(:push_this)
        begin
          binding_self.push_this(self)
          proc.call(*args, &block)
        ensure
          binding_self.pop_this
        end
      end

      def push_this(object)
        (@these ||= []).push(object)
      end
    
      def pop_this
        @these.pop if @these
      end
    
      def this
        (@these && @these.last) || self
      end

      def this_eval(&block)
        this.instance_eval(&block)
      end

      attr_reader :contextual_methods

      def contextual_method(*methods)
        methods.each do |method|
          (@contextual_methods ||= []) << method.to_sym
        end
      end
      
      def contextual_method?(method)
        to_class.self_and_ancestors.each do |ancestor|
          return true if ancestor.contextual_methods &&
            ancestor.contextual_methods.include?(method.to_sym)
        end
        false
      end
      
      def method_missing(method_name, *args, &block)
        if this != self && this.contextual_method?(method_name)
          this.send(method_name, *args, &block)
        else
          super
        end
      end
    end
  end
end

class Object #:nodoc:
  include Kinda::Core::This
end

class Proc #:nodoc:
  include Kinda::Core::This::ProcExtension
end
