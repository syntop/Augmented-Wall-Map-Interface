exports = window

class Message
    constructor: (@address) ->
        @values = []
    
    addString: (v) ->
        @values.push type: 'string', value: v
    
    addInt: (v) ->
        @values.push type: 'int', value: v
    
    addFloat: (v) ->
        @values.push type: 'float', value: v
    
    addBool: (v) ->
        @values.push type: 'bool', value: v
    
    addBlob: (v) ->
        @values.push type: 'blob', value: v
    
    addTimeTag: (v) ->
        @values.push type: 'timetag', value: v
    
    addImpulse: ->
        @values.push type: 'impulse', value: 1
    
    addNull: ->
        @values.push type: 'null', value: null
    
    serialize: ->
        encodeURIComponent(JSON.stringify(@values))
    
    send: ->
        location.href = "taucher:/#{@address}/#{@serialize()}"

exports.Message = Message

# $ ->
#     if (exports.console)
#         exports.console =
#             log: (msg) ->
#                 $('#console').html(msg)
