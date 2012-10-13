# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/html_minify',  __FILE__)

Gem::Specification.new do |s|
  s.name = %q{rack-html-minify}
  s.version = Rack::HtmlMinify.version
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Jerome Touffe-Blin"]
  s.email = %q{jtblin@gmail.com}
  s.homepage = %q{http://github.com/jtblin/rack-html-minify}
  s.summary = %q{HTML Minify}
  s.description = %q{A middleware that adds HTML minification to Rack applications}
  s.required_rubygems_version = ">= 1.3.6"
  s.add_runtime_dependency(%q<rack>, [">= 1.4.0"])
  s.add_development_dependency(%q<rack-test>, [">= 0.3.0"])

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

end

