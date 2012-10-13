# HtmlMini

The *html_mini* gem includes a simple module and a middleware that adds HTML minification
for Rack applications. HtmlMini is optimised for speed over syntax preservation.

## Disclaimer

This is an early release that has not been tested in production. I wanted to try out creating a rack middleware and a gem.
The minify logic is **minimal** therefore unexpected issues can occur. **Use at your own risk**

If you have inline Javascript in your Html, make sure all lines are ended by semi colons, and that you only use multi or full line comments, no comments at end of line.

## Using with Rack application

*HtmlMini* can be used with any Rack application,
for example with a **Sinatra** application.
If your application includes a rackup file
or uses *Rack::Builder* to construct the application pipeline, 
simply require and use as follows:

    require 'rack/minify'
    use Rack::Minify
    run app

## Using with Rails 3

In order to use, include the following in a Rails application
*Gemfile* file:

    gem 'html_mini'

*config/application.rb* file:

    require 'rack/minify'
    config.middleware.insert_before Rack::ETag, Rack::Minify

Check the Rack configuration:

    rake middleware

## Credits

* [rack-htmltidy](https://github.com/wbzyl/rack-htmltidy): An Outdated Tidy Rack middleware
* [railscast.com](http://railscasts.com/episodes/151-rack-middleware): A screencast on middleware (a bit old)

## Author

Jerome Touffe-Blin, [@jtblin](https://twitter.com/jtlbin), [http://www.linkedin.com/in/jtblin](http://www.linkedin.com/in/jtblin)

## License

Html-Mini is copyright 2012 Jerome Touffe-Blin and contributors. It is licensed under the BSD license. See the include LICENSE file for details.

