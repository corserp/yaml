require File.join(File.dirname(__FILE__), 'core', 'module')
require File.join(File.dirname(__FILE__), 'core', 'object')
ruby_files = Dir.glob(File.join(File.dirname(__FILE__), 'core', '*.rb'))
ruby_files.each { |file| require file }

module Kinda #:nodoc:
  # Basic helpers used by other kinda projects
  module Core
    include Accessor
    include Forwardable
  end
end