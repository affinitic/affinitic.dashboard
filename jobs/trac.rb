require 'net/http'
require 'uri'
require 'nokogiri'
require 'htmlentities'
require_relative 'rss_library'

myfile = File.open('../urltrac.json', 'r')
myurl = JSON.parse(myfile.read)

news_feeds = {
  "trac" => myurl['url']
}

news_list = []
news_feeds.each do |widget_id, feed|
  begin
    news_list.push(RssNews.new(widget_id, feed))
    puts 'DCFVHJKLMLKJHGCFDXDRTYHUIJOL??N BGFG'
    puts news_list
  rescue Exception => e
    puts e.to_s
  end
end

SCHEDULER.every '5s', :first_in => 0 do |job|
  news_list.each do |news|
    headlines = news.latest_headlines(login = myurl['login'], password = myurl['password'], debug=true)
    send_event(news.widget_id, { :headlines => headlines })
    puts news.widget_id
  end
end
