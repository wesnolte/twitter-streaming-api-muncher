# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter-stream}
  s.version = "0.1.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Vladimir Kolesnikov}]
  s.date = %q{2010-10-05}
  s.description = %q{Simple Ruby client library for twitter streaming API. Uses EventMachine for connection handling. Adheres to twitter's reconnection guidline. JSON format only.}
  s.email = %q{voloko@gmail.com}
  s.extra_rdoc_files = [%q{README.markdown}]
  s.files = [%q{README.markdown}]
  s.homepage = %q{http://github.com/voloko/twitter-stream}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Twitter realtime API client}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0.12.8"])
      s.add_runtime_dependency(%q<simple_oauth>, ["~> 0.1.4"])
      s.add_runtime_dependency(%q<http_parser.rb>, ["~> 0.5.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0.12.8"])
      s.add_dependency(%q<simple_oauth>, ["~> 0.1.4"])
      s.add_dependency(%q<http_parser.rb>, ["~> 0.5.1"])
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0.12.8"])
    s.add_dependency(%q<simple_oauth>, ["~> 0.1.4"])
    s.add_dependency(%q<http_parser.rb>, ["~> 0.5.1"])
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
  end
end
