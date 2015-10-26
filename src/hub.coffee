define (require) ->
    ''' a global singleton object which handles application state
    and routes global events'''

    dispatch = d3.dispatch('cameraChange', 'tick')

    hub = {}

    hub.on = (type, handler) ->
        dispatch.on(type, handler)
        return hub

    hub.cameraChange = () ->
        dispatch.cameraChange()
        return hub

    hub.tick = () ->
        #console.log('t')
        dispatch.tick()
        return hub

    return hub


