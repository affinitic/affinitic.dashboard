require 'net/http'
require 'uri'
require 'nokogiri'
require 'htmlentities'

myfile = File.open('../urlbitbucket.json', 'r')
myurl = JSON.parse(myfile.read)

news_feeds = {
  "bitbucket" => myurl['url']
}

Decoder = HTMLEntities.new

class News
  def initialize(widget_id, feed)
    @widget_id = widget_id
    uri = URI.parse(feed)
    @path = uri.path + '?' + uri.query
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
  end

  def widget_id()
    @widget_id
  end

  def latest_headlines()
    response = @http.request(Net::HTTP::Get.new(@path))
    doc = Nokogiri::XML(response.body)
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

@News = []
news_feeds.each do |widget_id, feed|
  begin
    @News.push(News.new(widget_id, feed))
  rescue Exception => e
    puts e.to_s
  end
end

SCHEDULER.every '60m', :first_in => 0 do |job|
  @News.each do |news|
    headlines = news.latest_headlines()
    send_event(news.widget_id, { :headlines => headlines })
  end
end
