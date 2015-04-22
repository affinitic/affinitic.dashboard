#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'date'
require 'cgi'

# Config
# make sure your URLs end with /full, not /simple (which is default)!
# ------

myfile = File.open('pass/calendar.json', 'r')
myobject = JSON.parse(myfile.read)

calendars = [{name: 'Private', url: myobject['url']}]
events = Array.new

SCHEDULER.every '100s', :first_in => 0 do |job|
	events = Array.new
	min = CGI.escape((DateTime.now()-7).to_s)
	max = CGI.escape((DateTime.now()+365).to_s)
	
	calendars.each do |calendar|
		url = calendar[:url]+"?singleevents=true&orderby=starttime&start-min=#{min}&start-max=#{max}&hl=fr"
		reader = Nokogiri::XML(open(url))
		reader.remove_namespaces!
		reader.xpath("//feed/entry").each do |e|
			title = e.at_xpath("./title").text
			content = e.at_xpath("./content").text
			when_node = e.at_xpath("./when")
			events.push({title: title,
				body: content ? content.split("\n").first.sub('&lt;br&gt;', '') : "",
				calendar: calendar[:name],
				when_start_raw: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_time.to_i : 0,
				when_end_raw: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_time.to_i : 0,
				when_start: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_s : "No time",
				when_end: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_s : "No time"
			})
		end
	end

  events.sort! { |a,b| a[:when_start_raw] <=> b[:when_start_raw] }
	events = events.slice!(0,15) # 15 elements is probably enough...
  events = events.reverse

  status = ''
  if events.length == 0
    status = 'Aucun evenement futur'
  end
	
	send_event('calendar_events',
             events: events,
             status: status)
end
