module Kinda
  module Core
    module HashExtension
    	def delete_value(value)
    	  delete_if { |k, v| v == value }
    	end
    end
  end
end

class Hash #:nodoc:
  include Kinda::Core::HashExtension
end