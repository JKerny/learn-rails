# -*- encoding: utf-8 -*-
# stub: rails_layout 1.0.21 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_layout"
  s.version = "1.0.21"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel Kehoe"]
  s.date = "2014-08-12"
  s.description = "Generates Rails application layout files for use with various front-end frameworks."
  s.email = ["daniel@danielkehoe.com"]
  s.homepage = "http://github.com/RailsApps/rails_layout/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Rails generator creates application layout files for Bootstrap and other frameworks."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
