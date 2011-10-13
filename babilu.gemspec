# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{babilu}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tore Darell", "Peter Zotov"]
  s.date = %q{2011-07-20}
  s.description = %q{Babilu converts all your translations into JavaScript so you can use them on the client side. It mimicks the Ruby/Rails I18n API and works in pretty much the same way}
  s.email = %q{}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "MIT-LICENSE",
    "README",
    "Rakefile",
    "VERSION",
    "babilu.gemspec",
    "init.rb",
    "lib/babilu.rb",
    "lib/babilu/generator.rb",
    "lib/babilu/i18n_extensions.rb",
    "lib/babilu/include_tag_helper.rb",
    "lib/javascripts/babilu.js",
    "test/babilu_test.rb",
    "test/js/JSSpec.css",
    "test/js/JSSpec.js",
    "test/js/diff_match_patch.js",
    "test/js/specs.js",
    "test/js/test.html",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/whitequark/babilu}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Rails plugin for javascript i18n}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<lucy>, [">= 0"])
    else
      s.add_dependency(%q<lucy>, [">= 0"])
    end
  else
    s.add_dependency(%q<lucy>, [">= 0"])
  end
end

