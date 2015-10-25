define (require) ->
    ''' a global singleton object which handles application state
    and routes global events'''

    dispatch = d3.dispatch('cameraChange')

    hub = {}

    hub.on = (type, handler) ->
        dispatch.on(type, handler)
        return hub

    hub.cameraChange = (dealer) ->
        dispatch.cameraChange()
        return hub

    return hub


