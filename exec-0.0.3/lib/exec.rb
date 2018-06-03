module Exec
  class NonZeroExitCodeException < StandardError
    def initialize
    end
  end
  class CommandNotFoundException < StandardError
    def initialize
    end
  end
  class << self
    alias :_system :system
    def system(*args)
      case _system(*args)
        when true ; true
        when nil  ; raise CommandNotFoundException
        else $?.exitstatus
      end
    end
    def system_v(*args)
      $stderr.puts(*args)
      system(*args)
    end
    def system!(*args)
      case _system(*args)
        when true ; true
        when nil  ; raise CommandNotFoundException
        else      ; raise NonZeroExitCodeException
      end
    end
    def system_v!(*args)
      $stderr.puts(*args)
      system!(*args)
    end
  end
end

