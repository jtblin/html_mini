require 'rake'
require 'rake/testtask'
require File.expand_path('../lib/rack/html_minify',  __FILE__)

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  #SO MUCH NOISE
  #test.warning = true
  test.pattern = 'test/**/test_*.rb'
end

task :build do
  system "gem build rack-html-minify.gemspec"
end

task :release => :build do
  system "gem push rack-html-minify-#{Rack::HtmlMinify.version}"
end

task :default => :test
