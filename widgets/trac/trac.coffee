class Dashing.trac extends Dashing.Widget

    constructor: ->
        super
        @old_data_affinitic = ''
        @old_data_arsia = ''
        @old_data_cadredeville = ''

    onData: (data) ->

        new_data_affinitic = data.item.affinitic.value
        # Data changed
        if @old_data_affinitic != new_data_affinitic
            # Do not expose at page load

            if @old_data_affinitic != ''
                @enlarge()

        @old_data_affinitic = new_data_affinitic

        new_data_arsia = data.item.arsia.value
        # Data changed
        if @old_data_arsia != new_data_arsia
            # Do not expose at page load

            if @old_data_arsia != ''
                @enlarge()

        @old_data_arsia = new_data_arsia

        new_data_cadredeville = data.item.cadredeville.value
        # Data changed
        if @old_data_cadredeville != new_data_cadredeville
            # Do not expose at page load

            if @old_data_cadredeville != ''
                @enlarge()

        @old_data_cadredeville = new_data_cadredeville

    enlarge: ->
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
