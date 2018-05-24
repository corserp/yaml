# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "heredoc_unindent"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adriano Mitre"]
  s.date = "2015-04-15"
  s.description = "This gem removes common margin from indented strings, such as the ones\nproduced by indented heredocs. In other words, it strips out leading whitespace\nchars at the beggining of each line, but only as much as the line with the\nsmallest margin.\n\nIt is acknowledged that many strings defined by heredocs are just code and fact\nis that most parsers are insensitive to indentation. If, however, the strings\nare to be used otherwise, be it for printing or testing, the extra indentation\nwill probably be an issue and hence this gem."
  s.email = ["adriano.mitre@gmail.com"]
  s.extra_rdoc_files = ["History.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = ["History.rdoc", "Manifest.txt", "README.rdoc"]
  s.homepage = "https://github.com/adrianomitre/heredoc_unindent"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "This gem removes common margin from indented strings, such as the ones produced by indented heredocs"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.13"])
    else
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.13"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.13"])
  end
end
