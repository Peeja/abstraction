# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{abstraction}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Jaros"]
  s.date = %q{2009-05-30}
  s.description = %q{Abstract classes for Ruby}
  s.email = %q{peter.a.jaros@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "History.txt",
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "examples/cars.rb",
    "lib/abstraction.rb",
    "spec/abstraction_spec.rb",
    "spec/spec.opts"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Peeja/abstraction}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{abstraction}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Abstract classes for Ruby}
  s.test_files = [
    "spec/abstraction_spec.rb",
    "examples/cars.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
