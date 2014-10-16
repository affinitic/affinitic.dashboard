class Dashing.trac extends Dashing.Widget

    constructor: ->
        super
        @old_data = ''

    onData: (data) ->

        new_data = data.item.value
        el = $(@node).parent()
        # Data changed
        if @old_data != new_data
            if new_data == '0'
                $(@node).css('background-color', '#8bb73f')
            else
                $(@node).css('background-color', '#D23125')
                # Do not expose at page load
                console.log 'Dashboard youpie'

                if @old_data != ''
                    el = $(@node).parent()
                    width = el.width()
                    height = el.height()
                    oldposition = el.position()
                    
                    el.expose(
                        onBeforeLoad: () ->
                              el.animate({width:590,height:670, top:170, left:605})
                        onBeforeClose: () ->
                              el.animate({width:width, height:height, top:oldposition['top'], left:oldposition['left']})
                    )

                    setTimeout (-> $.mask.close()), 10000

        @old_data = new_data
