# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "exec"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Morgan Christiansson"]
  s.date = "2011-12-19"
  s.description = "Exec#system Exec#system_v Exec#system! Exec#system_v!"
  s.email = "executils@mog.se"
  s.homepage = "http://github.com/morganchristiansson/exec"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "A mix between Kernel#system and FileUtils"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
