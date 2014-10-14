class Dashing.trac extends Dashing.Widget

    constructor: ->
        super
        @old_data = ''

    onData: (data) ->

        new_data = data.item.value

        # Data changed
        console.log @old_data
        console.log new_data

        if @old_data != new_data
            if new_data == '0'
                $(@node).css('background-color', '#8bb73f')
            else
                $(@node).css('background-color', '#e3394f')
                # Do not expose at page load
                if @old_data != ''
                    $(@node).parent().expose()
                    setTimeout (-> $.mask.close()), 5000

        @old_data = new_data

