# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bson}
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jim Menard}, %q{Mike Dirolf}, %q{Kyle Banker}]
  s.date = %q{2011-11-29}
  s.description = %q{A Ruby BSON implementation for MongoDB. For more information about Mongo, see http://www.mongodb.org. For more information on BSON, see http://www.bsonspec.org.}
  s.email = %q{mongodb-dev@googlegroups.com}
  s.executables = [%q{b2json}, %q{j2bson}]
  s.files = [%q{bin/b2json}, %q{bin/j2bson}]
  s.homepage = %q{http://www.mongodb.org}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby implementation of BSON}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
