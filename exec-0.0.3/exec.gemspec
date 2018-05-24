lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'exec/version'

Gem::Specification.new do |s|
  s.name = 'exec'
  s.version = Exec::VERSION
  s.date = '2011-12-19'
  s.summary = 'A mix between Kernel#system and FileUtils'
  s.description = 'Exec#system Exec#system_v Exec#system! Exec#system_v!'
  s.authors = ['Morgan Christiansson']
  s.email = 'executils@mog.se'
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/morganchristiansson/exec'
end

