class Dashing.nouzotre extends Dashing.Widget

    constructor: ->
        super
        @old_data = ''
        @old_data2 = ''
    onData: (data) ->

        new_data = data.item.milestone.date
        new_data2 = data.item.milestone.photo
        el = $(@node).parent()
        # Data changed
        if @old_data != new_data or @old_data2 != new_data2
        # Do not expose at page load

            if @old_data != '' or @old_data2 != ''
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
        @old_data2 = new_data2
