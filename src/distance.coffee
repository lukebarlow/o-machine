# returns the distance between two points

define (require) ->

    hypotenuse = require('cs!hypotenuse')

    return (p1, p2) ->
        dx = p1[0] - p2[0]
        dy = p1[1] - p2[1]
        return hypotenuse(dx, dy)