$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'exec/version'
require 'exec'

desc 'build .gem file' 
task :build do
  Exec.system_v "gem build exec.gemspec"
end
 
desc 'push .gem file'
task :release => :build do
  Exec.system_v "gem push exec-#{Exec::VERSION}.gem"
end

desc 'build and install .gem file'
task :install => :build do
  Exec.system_v "gem install exec-#{Exec::VERSION}.gem"
end

desc 'tag current commit as Exec::VERSION and push tag'
task :tag do
  v = Exec::VERSION.gsub(/\./, '_')
  Exec.system_v "git tag REL_#{v}"
  Exec.system_v "git push origin REL_#{v}"
end

