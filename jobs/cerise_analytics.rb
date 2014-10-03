require_relative 'google_analytics_library'

cerise_analytics = GoogleAnalytics.new('pass/pwdgoogleapi.json', 'ARSIA')

SCHEDULER.every '10m', :first_in => 0 do
    send_event('cerise_analytics', points: cerise_analytics.GetVisitors())
end
