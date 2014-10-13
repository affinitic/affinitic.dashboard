class Dashing.trac extends Dashing.Widget

    onData: (data) ->
        if data.item.value == '0'
            $(@node).css('background-color', '#8bb73f')
        else
            $(@node).css('background-color', '#e3394f')

