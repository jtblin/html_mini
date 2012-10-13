# Rack HtmlMinify

The *rack-html-minify* gem is a middleware that adds HTML minification
for Rack applications.

# Disclaimer

This is an early release that has not been tested in production. The minify logic is **minimal** therefore unexpected issues can occur. **Use at your own risk**

## Using with Rack application

*Rack::HtmlMinify* can be used with any Rack application,
for example with a **Sinatra** application.
If your application includes a rackup file
or uses *Rack::Builder* to construct the application pipeline, 
simply require and use as follows:

    require 'rack/html-minify'
    use Rack::HtmlMinify
    run app

## Using with Rails 2.3.2

In order to use include the following in a Rails application
*Gemfile* file:

    gem 'rack-html-minify'

*config/application.rb* file:

    config.middleware.insert_before Rack::ETag, Rack::HtmlMinifier

Check the Rack configuration:

    rake middleware

## Credits

* [rack-htmltidy](https://github.com/wbzyl/rack-htmltidy): An Outdated Tidy Rack middleware
* [railscast.com](http://railscasts.com/episodes/151-rack-middleware): A screencast on middleware (a bit old)

## Author

Jerome Touffe-Blin, [@jtblin](https://twitter.com/jtlbin), [http://www.linkedin.com/in/jtblin](http://www.linkedin.com/in/jtblin)

