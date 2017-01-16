class Dashing.GoogleCalendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events...

    start = moment(event.start)
    end = moment(event.end)

    @set('event',event)
    @set('event_date', start.format('DD/MM/YY'))
    @set('event_times', "de " + start.format('H[h]mm') + " à " + end.format('H[h]mm'))

    next_events = []
    for next_event in rest
      start = moment(next_event.start)
      start_date = start.format('DD/MM')
      start_time = start.format('H[h]mm')
      if start_time == '0h00'
         start_time = ''
      else
         start_time = 'à ' + start_time

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
