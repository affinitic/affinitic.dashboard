require_relative 'google_analytics_library'

gites_analytics = GoogleAnalytics.new('../pwdgoogleapirss.json', 'GITES')

SCHEDULER.every '10s', :first_in => 0 do
    send_event('gites_analytics', points: visitors = gites_analytics.GetVisitors())
end
