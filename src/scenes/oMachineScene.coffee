define (require) ->

    Surface = require('cs!Surface')
    Camera = require('cs!Camera')
    Viewer = require('cs!Viewer')
    Stripes = require('cs!Stripes')

    pillarWidth = 0.6

    ###
    The pillars are organised around the 0,0 point in the centre. The positions
    are given in units of [width of pillar] here, and then converted into
    metres when we calculate the positions of the surfaces
    ###

    pillars = [
        # along the top
        [-3.5, 2.5],
        [-1.5, 2.5],
        [0.5, 2.5],
        [2.5, 2.5],

        # left hand side
        [-3.5, 0.5],
        [-3.5, -1.5],

        # right hand side
        [2.5, 0.5],
        [2.5, -1.5],

        # bottom
        [-3.5, -3.5],
        [-1.5, -3.5],
        [0.5, -3.5],
        [2.5, -3.5],
    ]

    surfaces = []
    for [x, y] in pillars
        x *= pillarWidth
        y *= pillarWidth
        surfaces = surfaces.concat([
            [[x,y],[x,y + pillarWidth]],
            [[x,y + pillarWidth], [x + pillarWidth, y + pillarWidth]],
            [[x + pillarWidth, y + pillarWidth],[x + pillarWidth, y]],
            [[x + pillarWidth, y], [x,y]]
        ])

    surfaces = surfaces.map(([p1, p2]) -> new Surface(p1, p2))

    r2 = Math.sqrt(2)
    cameraDistance = 14
    cameraViewAngle = 2 * Math.atan(2.1 * Math.sqrt(2)  / 14)

    cameras = [
        new Viewer([0, 10], [0,0], Math.PI / 4),
        new Camera([-cameraDistance / r2, cameraDistance / r2], [0,0], cameraViewAngle)
            #.stripes([[0, 0.5, 1]]),
            .stripes([[0, 1, 0.7]]),
            # .stripes([
            #     [0, 0.1, 1],
            #     [0.2, 0.3, 1],
            #     [0.4, 0.5, 1],
            #     [0.6, 0.7, 1],
            #     [0.8, 0.9, 1]
            # ])
        new Camera([cameraDistance / r2, cameraDistance / r2], [0,0], cameraViewAngle)
            #.stripes([[0, 0.5, 1]]),
            .stripes([[0, 1, 0]]),
        new Camera([cameraDistance / r2, -cameraDistance / r2], [0,0], cameraViewAngle)
            #.stripes([[0, 0.5, 1]]),
            .stripes([[0, 1, 0.7]]),
        new Camera([-cameraDistance / r2, -cameraDistance / r2], [0,0], cameraViewAngle)
            #.stripes([[0, 0.5, 1]]),
            .stripes([[0, 1, 0]]),
    ]

    return {
        surfaces : surfaces,
        cameras : cameras
    }