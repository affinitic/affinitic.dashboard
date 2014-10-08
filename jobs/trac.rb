require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'htmlentities'
require_relative 'rss_library'
require 'json'
require 'httparty'

myfile = File.open('pass/urltrac.json', 'r')
myurl = JSON.parse(myfile.read)

news_feeds = {
  "trac" => myurl['url']
}

news_list = []
news_feeds.each do |widget_id, feed|
  begin
    news_list.push(RssNews.new(widget_id, feed))
  rescue Exception => e
    puts e.to_s
  end
end

SCHEDULER.every '5s', :first_in => 0 do |job|
  news_list.each do |news|
    headlines = news.latest_headlines(login = myurl['login'], password = myurl['password'], debug=true)
    send_event(news.widget_id, { :headlines => headlines })
  end
end
