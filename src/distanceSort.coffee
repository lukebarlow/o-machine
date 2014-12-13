# sorts by the distance between a point and surfaces
define (require) ->

    distance = require('cs!distance')

    return (point) ->
        return (surfaceA, surfaceB) ->
            return distance(point, surfaceA.midpoint) - distance(point, surfaceB.midpoint)
            
