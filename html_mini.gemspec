# -*- encoding: utf-8 -*-
require File.expand_path('../lib/html_mini',  __FILE__)

Gem::Specification.new do |s|
  s.name = %q{html_mini}
  s.version = HtmlMini::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Jerome Touffe-Blin"]
  s.email = %q{jtblin@gmail.com}
  s.license = 'BSD'
  s.homepage = %q{http://github.com/jtblin/html_mini}
  s.summary = %q{HTML Mini}
  s.description = %q{Simple, fast HTML minification for Rack applications}
  s.required_rubygems_version = ">= 1.3.6"
  s.add_runtime_dependency(%q<rack>, [">= 1.4.0"])
  #s.add_development_dependency(%q<rack-test>, [">= 0.3.0"])

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

end

