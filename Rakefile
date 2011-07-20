require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Babilu plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the Babilu plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Babilu'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification. See http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "babilu"
  gem.homepage = "http://github.com/whitequark/babilu"
  gem.license = "MIT"
  gem.summary = %Q{Rails plugin for javascript i18n}
  gem.description = %Q{Babilu converts all your translations into JavaScript so you can use them on the client side. It mimicks the Ruby/Rails I18n API and works in pretty much the same way}
  gem.email = ""
  gem.authors = ["Tore Darell", "Peter Zotov"]
  gem.add_runtime_dependency 'lucy'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new
