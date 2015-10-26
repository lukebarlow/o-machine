define (require) ->

    surfaces = require('cs!scenes/oMachineSurfaces')
    cameras = require('cs!scenes/oMachineCamerasAndViewer')

    # some test stripes

    cameras[1].stripes([
        [0, 0.1, 1],
        [0.2, 0.3, 1],
        [0.4, 0.5, 1],
        [0.6, 0.7, 1],
        [0.8, 0.9, 1]
    ])

    cameras[2].stripes([[0, 0.5, 1]])

    cameras[3].stripes([[0, 0.33, 0.3], [0.66, 1, 0.4]])

    cameras[4].stripes([
        [0, 0.2, 0.25],
        [0.3, 0.5, 0.25],
        [0.6, 0.8, 0.25],
        [0.9, 0.1, 0.25]
    ])

    return {
        surfaces : surfaces,
        cameras : cameras
    }