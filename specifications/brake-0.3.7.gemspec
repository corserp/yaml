# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "brake"
  s.version = "0.3.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Slaughter", "Jonathan Chrisp"]
  s.date = "2013-02-14"
  s.description = "A Cucumber options parser wrapper for Rake, because, cake was already taken!"
  s.email = ["bens@brandwatch.com", "jonathan@brandwatch.com"]
  s.executables = ["brake"]
  s.files = ["bin/brake"]
  s.homepage = "https://github.com/jonathanchrisp/brake"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "A Cucumber options parser wrapper for Rake."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, ["= 0.9.2.2"])
    else
      s.add_dependency(%q<rake>, ["= 0.9.2.2"])
    end
  else
    s.add_dependency(%q<rake>, ["= 0.9.2.2"])
  end
end
