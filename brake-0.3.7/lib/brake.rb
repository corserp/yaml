# @author Ben Slaughter, Jonathan Chrisp
require 'rake'
require 'optparse'

begin
  load 'Brakefile'
rescue LoadError
  puts "Brakefile load error"
  puts "please check your brake file"
  exit
end

# @author Ben Slaughter
# class brake the heart and soul of brake
# simply this is a wrapper disigned to give the end user some control by being able to pass command line options
# but still having the conviniance of rake tasks
# The tool has now evolved and if used cleverly could be used by anyone
class Brake
  # Starts the Brake Class
  # If there is no information given to brake it will rin the 'default task'
  def genesis
    # creates the default arguments
    # -P Disables profiles, we no longer need it as all data is given at command line
    # -s removes the extra source code line no note displayed in the command line
    @arguments = { :req => "-P -s" }
    # Untangle is false untill the options parser has run
    @untangle = false
    # Brake can run Its task several times
    @taskIterations = 1
    # This is the code that is returned by brake
    # If any of the tests return a 1 it will return 1
    @returnCode = 0

    # Runs the options parser, Arguments and Untangle are now inst variables
    self.parse_command_line_options

    # Outputs the brake version at runtime
    if @brakeVersion
      puts "Brake Version:" + Gem.loaded_specs["brake"].version.to_s
    end

    self.debug( ARGV )
    # Default is assigned to the ARGV if there is no task given
    ARGV.push('default') if ARGV == []
    # Brake only runs one task at a time
    @taskIterations.times do
      self.run_rake_task( ARGV[0] )
    end

    # This code is commented out to keep things simple
    # Brake will execute the first task and then drop everything else
    # This stops incorrect options causing problems
    # ARGV.each do | task |
    #   self.debug( task )
    #   self.run_rake_task( task )
    # end
    return @returnCode
  end

  # prints out the passed message if debug/untangle is on
  def debug( message )
    if @untangle
      puts message.to_s
    end
  end

  # Parses the options from the command line
  # Converts the parsed information into a Hash
  # The Hash is then returned
  # @return [hash] arguments a hash containg the parsed and  data
  def parse_command_line_options
    begin
      # parses the options from the command line
      OptionParser.new do |opts|
        opts.banner = "\nBrake, A Cucumber options parser wrapper for Rake, because, cake was already taken!, Give Rake a Brake.\nUsage: brake <task> [options]"
        opts.separator ""
        opts.separator "Cucumber options:"
         opts.on("-t", "--tags @high,@login", Array, "Array:  A list of all tagged test to be run" ) do |opt|
          @arguments[:tags] ||= []
          @arguments[:tags].push( "--tags #{opt.join(',')}" )
        end
        opts.on("-d", "--dry-run", "Bool: Invokes the formatters without executing steps" ) do |opt|
          @arguments[:dry_run] = "--dry-run"
        end
        opts.on("-v", "--verbose", "Bool: Show the files and features loaded" ) do |opt|
          @arguments[:verbose] = "--verbose"
        end
        opts.on("-f", "--format pretty", String, "String: How to format the output (Default: pretty)" ) do |opt|
          @arguments[:format] = "--format #{opt}"
        end
        opts.on("-S", "--strict", "Bool: Fail if there are and undefined or pending steps" ) do |opt|
          @arguments[:strict] = "--strict"
        end
        opts.on("-n", "--name featureName", String, "String: Only execute features with a partial match to the given name" ) do |opt|
          @arguments[:name] = "--name #{opt}"
        end
        opts.on("-g", "--guess", "Bool: Guess best match for ambiguous steps" ) do |opt|
          @arguments[:guess] = "--guess"
        end
        opts.on("-x", "--expand", "Bool: Expand scenario outline tables in output" ) do |opt|
          @arguments[:expand] = "--expand"
        end

        opts.separator ""
        opts.separator "Global options:" 
        opts.on("-e", "--enviroment release", String, "String: The enviroment to run the tests against eg Release" ) do |opt|
          @arguments[:env] = "ENVIRONMENT=#{opt.downcase}"
        end
        opts.on("-l", "--log_level debug", String, "String: The log output level debug|info" ) do |opt|
          @arguments[:log_level] = "LOGLEVEL=#{opt.downcase}"
        end
        opts.on("-c", "--controller chrome", String, "String: The type of controller to run (API, Chrome, Safari)" ) do |opt|
          @arguments[:controller] = "CONTROLLER=#{opt.downcase}"
        end
        opts.on("--[no-]headless", "Bool: To turn on/off headless mode (only works on Linux!)" ) do |opt|
          @arguments[:headless] = "HEADLESS=#{opt.to_s}"
        end
        opts.on("--[no-]cleanup", "Bool: To turn on/off setup cleanup" ) do |opt|
          @arguments[:cleanup] = "CLEANUP=#{opt.to_s}"
        end
        opts.on("--[no-]database", "Bool: Defines whether to log out to the database" ) do |opt|
          @arguments[:database] = "DATABASE=#{opt}"
        end
        opts.on("--[no-]jenkins", "Bool: Defines whether to log out to the jenkins specific database" ) do |opt|
          @arguments[:database] = "DATABASE=#{opt}"
          @arguments[:jenkins] = "JENKINS=#{opt}"
        end      
        opts.on("--retries 3", String, "String: The number of retries to perform on element methods" ) do |opt|
          @arguments[:retries] = "RETRIES=#{opt.downcase}"
        end
        opts.on("--timeouts 10", String, "String: The length of the timeouts on element methods" ) do |opt|
          @arguments[:timeouts] = "TIMEOUTS=#{opt.downcase}"
        end

        opts.separator ""
        opts.separator "Web options:"
        opts.on("-s", "--screen 1280,1024", Array, "Array:  The width,hight of the browser window" ) do |opt|
          if opt.length != 2
            puts "Incorrect number of args for screen: " + opt.to_s
            exit
          end
          @arguments[:screen] = "SCREENWIDTH=#{opt[0].downcase} SCREENHEIGHT=#{opt[1].downcase}"
        end
        opts.on("-p", "--position 0,0", Array, "Array:  The x,y coords of the browser 0,0 top left" ) do |opt|
          if opt.length > 2
            puts "Incorrect number of args for position: " + opt.to_s
            exit
          end
          @arguments[:position] = "XPOSITION=#{opt[0].downcase} YPOSITION=#{opt[1].downcase}"
        end

        opts.separator ""
        opts.separator "Browser options:"
        opts.on("-H", "--[no-]highlight", "Bool: To turn on/off the highlight of elements" ) do |opt|
          @arguments[:highlight] = "HIGHLIGHT=#{opt.to_s}"
        end

        opts.separator ""
        opts.separator "Brake options:"
        opts.on("-V", "--version", "Bool: Output the current version of brake" ) do |opt|
          @brakeVersion = opt
        end
        opts.on("-I", "--iterate 5", String, "Int: Number of times to run the task" ) do |opt|
          @taskIterations = opt.to_i
        end
        opts.on("-U", "--[no-]untangle", "Bool: Turns Debug on/off" ) do |opt|
          @untangle = opt
        end
        opts.on_tail("-h", "--help", "You're Looking at it") do
          puts opts
          puts "\nFor further assistance please contact Ben Slaughter or Jonathan Chrisp"
          puts "bens@brandwatch.com or jonathan@brandwatch.com"
          exit
        end
      end.parse! # options parser
    rescue OptionParser::InvalidOption => e
      puts e.message
      self.debug( e.backtrace.to_s )
      exit
    end # begin
  end # def

  # Runs the given rake task with the given arguments
  # @param [string] task This is the name of the rake task to be invoked
  def run_rake_task( task )
    puts "running task: " + task
    self.debug( @arguments )
    begin
      if task.downcase == 'default'
        Rake::Task['default'].execute( @arguments )
      else
        Rake::Task[task].execute( @arguments )
      end # if
      
    # This caused me some problems while running tasks
    # There is no raise as several tasks may be run
    # and due to the design requierments of the wrapper I do not want the code to quit
    rescue RuntimeError => e
      @returnCode = 1
      puts "Brake Aborted!"
      puts e.message
      if @untangle
        e.backtrace.each do | line |
          self.debug( line )
        end
      else
        puts "( For full backtrace run again with --untangle )"
      end
    end # begin
  end # def
end # class