# calculates where two lines meet
define (require) ->

    line = require('cs!line')

    # intersection of x = X with y = ax + b
    intersectWithVertical = (X, a, b) ->
        return [X, (a * X) + b]


    cameraViewLineToCartesianLine = (camera, relativeAngle, length = 10) ->
        p = camera.position
        absoluteAngle = camera.facingAngle + relativeAngle
        x = p[0] + Math.sin(absoluteAngle) * length
        y = p[1] + Math.cos(absoluteAngle) * length
        return [p, [x,y]]


    cartesianCartesian = ([p1,p2],[p3,p4]) ->
        [a1, b1] = line(p1, p2)
        [a2, b2] = line(p3, p4)

        # if a is vertical, then we need to figure
        if not isFinite(a1)
            return intersectWithVertical(p1[0], a2, b2)
        if not isFinite(a2)
            return intersectWithVertical(p3[0], a1, b1)

        x = (b2 - b1) / (a1 - a2)
        y = a1 * x + b1

        return [x,y]


    cameraViewLineSurface = (camera, relativeAngle, surface) ->
        cameraLine = cameraViewLineToCartesianLine(camera, relativeAngle)
        return cartesianCartesian(cameraLine, [surface.p1, surface.p2])


    return {
        cameraViewLineToCartesianLine : cameraViewLineToCartesianLine,
        cartesianCartesian : cartesianCartesian,
        cameraViewLineSurface : cameraViewLineSurface
    }