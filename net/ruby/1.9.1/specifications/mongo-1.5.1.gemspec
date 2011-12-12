# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongo}
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jim Menard}, %q{Mike Dirolf}, %q{Kyle Banker}]
  s.date = %q{2011-11-29}
  s.description = %q{A Ruby driver for MongoDB. For more information about Mongo, see http://www.mongodb.org.}
  s.email = %q{mongodb-dev@googlegroups.com}
  s.executables = [%q{mongo_console}]
  s.extra_rdoc_files = [%q{README.md}]
  s.files = [%q{bin/mongo_console}, %q{README.md}]
  s.homepage = %q{http://www.mongodb.org}
  s.rdoc_options = [%q{--main}, %q{README.md}, %q{--inline-source}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby driver for the MongoDB}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bson>, ["= 1.5.1"])
    else
      s.add_dependency(%q<bson>, ["= 1.5.1"])
    end
  else
    s.add_dependency(%q<bson>, ["= 1.5.1"])
  end
end
