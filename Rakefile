require 'rake'
require 'rake/testtask'
require File.expand_path('../lib/html_mini',  __FILE__)

Rake::TestTask.new(:test) do |test|
  # TODO: add tests
  test.libs << 'test'
  # test.warning = true
  test.pattern = 'test/**/test_*.rb'
end

task :build do
  system "gem build html_mini.gemspec"
end

task :install => :build do
  system "gem install --no-ri --no-rdoc html_mini-#{HtmlMini::VERSION}.gem"
end

task :release => :build do
  system "gem push html_mini-#{HtmlMini::VERSION}.gem"
end

task :default => :test
