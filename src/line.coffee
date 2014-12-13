# calculates where two lines meet
define (require) ->

    # returns the a and b for the line expressed as ax + b
    return (p1, p2) ->
        a = (p2[1] - p1[1]) / (p2[0] - p1[0])
        b = p1[1] - a * p1[0]
        return [a, b] 