require './lib/icinga2'

icinga = Icinga2.new('pass/icinga2.json')
SCHEDULER.every '10s', :first_in => 0 do |job|

  # run data provider
  icinga.run

  warning_count = icinga.service_count_problems_warning.to_i
  critical_count = icinga.service_count_problems_critical.to_i
  status = critical_count > 0 ? "red" : (warning_count > 0 ? "yellow" : "green")
  send_event('icinga-arsia', { criticals: critical_count, warnings: warning_count, status: status, redirect: icinga.redirect})
end
