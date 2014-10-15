class Dashing.trac extends Dashing.Widget

    constructor: ->
        super
        @old_data = ''

    onData: (data) ->

        new_data = data.item.value

        # Data changed
        if @old_data != new_data
            if new_data == '0'
                $(@node).css('background-color', '#8bb73f')
            else
                $(@node).css('background-color', '#e3394f')
                # Do not expose at page load
                console.log 'Dashboard youpie'

                if @old_data != ''
                    el = $(@node).parent()
                    width = el.width()
                    el.expose(
                        onBeforeLoad: () ->
                            el.animate({width:width*2})
                        onBeforeClose: () ->
                            el.animate({width:width})
                    )

                    setTimeout (-> $.mask.close()), 10000

        @old_data = new_data
