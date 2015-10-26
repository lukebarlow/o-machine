define (require) ->

    Camera = require('cs!Camera')
    Viewer = require('cs!Viewer')

    r2 = Math.sqrt(2)
    cameraDistance = 14
    cameraViewAngle = 2 * Math.atan(2.1 * Math.sqrt(2)  / 14)

    cameras = [
        new Viewer([0, 10], [0,0], Math.PI / 4, 'Viewer'),
        new Camera([-cameraDistance / r2, cameraDistance / r2], [0,0], cameraViewAngle, 'Camera 1'),
        new Camera([cameraDistance / r2, cameraDistance / r2], [0,0], cameraViewAngle, 'Camera 2'),
        new Camera([cameraDistance / r2, -cameraDistance / r2], [0,0], cameraViewAngle, 'Camera 3'),
        new Camera([-cameraDistance / r2, -cameraDistance / r2], [0,0], cameraViewAngle, 'Camera 4')
    ]

    return cameras