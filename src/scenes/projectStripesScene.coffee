define (require) ->

    Surface = require('cs!Surface')
    Camera = require('cs!Camera')
    Viewer = require('cs!Viewer')
    Stripes = require('cs!Stripes')

    cameraViewAngle = 2 * Math.atan(2.1 * Math.sqrt(2)  / 14)

    surfaces = [
        #new Surface([-2, 0], [-1.5, 0]),
        #new Surface([-1, 0], [-0.5, 0]),
        new Surface([-3, 0], [3, 0]),
        #new Surface([1, 0], [1.5, 0]),
    ]

    cameras = [
        new Camera([0, 10], [0, 0], cameraViewAngle)
            .stripes([[0, 0.5, 0.6], [0.4, 0.6, 0.8]])
    ]

    window.surface = surfaces[0]

    return {
        surfaces : surfaces,
        cameras : cameras
    }