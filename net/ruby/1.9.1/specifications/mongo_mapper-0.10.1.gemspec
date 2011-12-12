# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongo_mapper}
  s.version = "0.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{John Nunemaker}]
  s.date = %q{2011-11-07}
  s.email = [%q{nunemaker@gmail.com}]
  s.executables = [%q{mmconsole}]
  s.files = [%q{bin/mmconsole}]
  s.homepage = %q{http://github.com/jnunemaker/mongomapper}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A Ruby Object Mapper for Mongo}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_runtime_dependency(%q<plucky>, ["~> 0.4.0"])
    else
      s.add_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<plucky>, ["~> 0.4.0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 3.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<plucky>, ["~> 0.4.0"])
  end
end
