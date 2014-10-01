require 'net/http'
require 'uri'
require 'nokogiri'
require 'htmlentities'

Decoder = HTMLEntities.new

class RssNews
  def initialize(widget_id, feed, use_ssl=false)
    @widget_id = widget_id
    uri = URI.parse(feed)
    @path = uri.path + '?' + uri.query
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = false
    if use_ssl
        @http.use_ssl = true
    end
  end

  def widget_id()
    @widget_id
  end

  def latest_headlines(login='', password='', debug=false)
    request = Net::HTTP::Get.new(@path)
    puts 'my request is :' +  request.to_s
    if login != ''
        request.basic_auth(login, password)
    end

    response = @http.request(request)
    doc = Nokogiri::XML(response.body)
    if debug
        puts doc
    end
    news_headlines = [];
    doc.xpath('//channel/item').each do |news_item|
      title = clean_html( news_item.xpath('title').text )
      summary = clean_html( news_item.xpath('description').text )
      news_headlines.push({ title: title, description: summary })
    end
    news_headlines
  end

  def clean_html( html )
    html = html.gsub(/<\/?[^>]*>/, "")
    html = Decoder.decode( html )
    return html
  end

end
