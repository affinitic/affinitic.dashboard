class Dashing.GoogleCalendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events...

    start = moment(event.start)
    end = moment(event.end)

    @set('event', event)
    @set('event_date', start.format('DD/MM/YY'))
    event_times = ''
    if start.format('H[h]mm') != '0h00'
        start = start.add({'hours': 1})
        end = end.add({'hours': 1})
        event_times = " - de " + start.format('H[h]mm') + " à " + end.format('H[h]mm')
    @set('event_times', event_times)

    next_events = []
    for next_event in rest
      start = moment(next_event.start)
      start_date = start.format('DD/MM')
      start_time = ''
      if start.format('H[h]mm') != '0h00'
          start = start.add({'hours': 1})
          start_time = 'à ' + start.format('H[h]mm')

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
