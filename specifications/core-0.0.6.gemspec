# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "core"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Manuel Vila"]
  s.date = "2009-10-11"
  s.description = "Basic helpers used by other kinda projects"
  s.email = "mvila@3base.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/kinda/core"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.1")
  s.rubyforge_project = "kinda-core"
  s.rubygems_version = "1.8.23"
  s.summary = "Basic helpers used by other kinda projects"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
