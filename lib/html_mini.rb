module HtmlMini

  VERSION = "0.0.3"

  def self.minify(html)
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
  end

end