# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "trollop"
  s.version = "2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Morgan"]
  s.date = "2012-08-14"
  s.description = "Trollop is a commandline option parser for Ruby that just\ngets out of your way. One line of code per option is all you need to write.\nFor that, you get a nice automatically-generated help page, robust option\nparsing, command subcompletion, and sensible defaults for everything you don't\nspecify."
  s.email = "wmorgan-trollop@masanjin.net"
  s.homepage = "http://trollop.rubyforge.org"
  s.require_paths = ["lib"]
  s.rubyforge_project = "trollop"
  s.rubygems_version = "1.8.23"
  s.summary = "Trollop is a commandline option parser for Ruby that just gets out of your way."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
