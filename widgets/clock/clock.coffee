class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    @set('time', h + ":" + m + ":" + s)
    @set('date', today.toDateString())

    colors = ['#141761',
        '#1e28b5',
        '#3d36cb',
        '#643eaf',
        '#924584',
        '#c14f56',
        '#e35c33',
        '#eb802a',
        '#ebba28',
        '#e2d392',
        '#5cd1d8',
        '#66efe9',
        '#74efd4',
        '#91ecd7',
        '#91ecd7',
        '#86cbeb',
        '#86cbeb',
        '#e46031',
        '#e46031',
        '#ab496c',
        '#5d3db9',
        '#2127a8',
        '#2127a8',
        '#141761',
        '#141761'
    ]

    number = parseInt( h, 10 );
    $(@node).css('background-color', colors[number])

  formatTime: (i) ->
    if i < 10 then "0" + i else i
