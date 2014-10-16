class Dashing.display extends Dashing.Widget

    constructor: ->
        super
        @old_messages = []

    is_empty: (obj) ->
        return true if not obj? or obj.length is 0

        return false if obj.length? and obj.length > 0

        for key of obj
            return false if Object.prototype.hasOwnProperty.call(obj,key) 

        return true

    onData: (data) ->
        # Construct data if empty (first load)
        if @is_empty(@old_messages)
            @old_messages = data.messages

        for message, index in data.messages
            for old_message, j in @old_messages
                if message.user == old_message.user
                    # Always apply data for actual user
                    if message.user == data.actualuser
                        @old_messages[j].message = message.message
                        data.messages[index].message = old_message.message
                    # Merge old data with new
                    else
                        if message.message != ''
                            @old_messages[j].message = message.message
                        else if old_message.message != ''
                            data.messages[index].message = old_message.message

