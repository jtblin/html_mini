require 'rack/utils'
require 'rack/logger'

module Rack
  class HtmlMini
    include Rack::Utils

    VERSION = "0.0.1"

    FORMAT = %{[HtmlMini #{VERSION}] %s - %s - [%s] %s "%s%s %s"\n}

    def initialize(app, opts={})
      @app = app
      @bench = opts[:bench] || false
      @logger = opts[:logger]
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, headers, response = @app.call(env)

      headers = HeaderHash.new(headers)

      if !STATUS_WITH_NO_ENTITY_BODY.include?(status) &&
          !headers['transfer-encoding'] &&
          headers['content-type'] &&
          headers['content-type'].include?("text/html") &&
          response.size > 0 &&
          response.first.size > 1

        start, size_before = Time.now, response.first.size if @bench

        html = minify(response.first)

        stop = Time.now and log(env, (stop-start).seconds, size_before, html.size) if @bench

        headers['Content-Length'] = html.size.to_s
        headers['Html-Minify'] = "version: #{VERSION}, time: #{(stop-start).seconds}, size: #{html.size-size_before}" if @bench

        response = [html]
      end

      [status, headers, response]
    end

    def minify(html)
      # 1. Remove all comments: gsub(/(<!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->|\/\*[^\*]*\*\/|^(\t|\s)*\/\/.*)/, '')
      # 1.1 html comments without special characters: <!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->
      # 1.2. Remove javascript comments e.g. /* */ and // \/\*[^\*]*\*\/ and ^(\t|\s)*\/\/.*
      # 3. Replace all carrier return and all tabs by a single space gsub(/(\n|\t)/, ' ').
      # 4. Replace any consecutive spaces by a single space gsub(/\s{2,}/, ' ')
      # 5. Remove space between tags gsub(/>\s+</, '><').strip.
      html.gsub(/(<!--(\w|\s|:|!|#|<|>|'|"|=|;|,|\.|\?)*-->|\/\*[^\*]*\*\/|^(\t|\s)*\/\/.*)/, '').
          gsub(/(\n|\t)/, ' ').
          gsub(/\s{2,}/, ' ').
          gsub(/>\s+</, '><').strip
      #html.gsub(/<!--(\w|\s|:|!|#)*-->/, '').
      #gsub(/\/\*[^\*]*\*\//, '').gsub(/^(\t|\s)*\/\/.*/, '').
      #gsub(/(\n|\t|\s{2,})/, ' ')
      #parser = Nokogiri::HTML::SAX::Parser.new(MyDoc.new)
      #parser.parse(html)
      #html
    end

    private

    def log(env, time, size_before, size)
      now = Time.now
      logger = @logger || env['rack.errors']

      logger.write FORMAT % [
          "Time: #{time}s",
          "Gain: #{size_before-size}/#{size_before.to_s}",
          now.strftime("%d-%b-%Y %H:%M:%S"),
          env["REQUEST_METHOD"],
          env["PATH_INFO"],
          env["QUERY_STRING"].empty? ? "" : "?"+env["QUERY_STRING"],
          env["HTTP_VERSION"]
      ]
    end
    
  end
end
