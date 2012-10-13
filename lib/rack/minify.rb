require 'html_mini'
require 'rack/utils'
require 'rack/logger'

module Rack
  class Minify
    include Rack::Utils

    FORMAT = %{[HtmlMini #{HtmlMini::VERSION}] %s - %s - [%s] %s "%s%s %s"\n}

    def initialize(app, opts={})
      @app = app
      @bench = opts[:bench] || true
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
          headers['content-type'].include?("text/html")

        body = ""
        response.each { |part| body += part }

        start, size_before = Time.now, body.size if @bench

        html = HtmlMini.minify(body) rescue nil

        stop = Time.now and log(env, (stop-start).seconds, size_before, html.size) if @bench

        headers['Content-Length'] = html.size.to_s
        headers['Html-Mini'] = "version #{HtmlMini::VERSION}, time #{(stop-start).seconds}s, size #{html.size-size_before} bytes" if @bench

        response = [html] unless html.nil?
      end

      [status, headers, response]
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