# takes an angle in radians and returns it in the range -PI < x <= PI
define (require) ->
    return (a) ->
        b = 2 * Math.PI
        result = (a % b + b) % b
        if result > Math.PI
            result -= 2 * Math.PI
        return result