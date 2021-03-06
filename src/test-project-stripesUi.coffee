define (require) ->

    Viewer = require('cs!Viewer')
    CameraProjector = require('cs!CameraProjector')
    Camera = require('cs!Camera')
    Surface = require('cs!Surface')
    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
    hub = require('cs!hub')
   
    surfaces = [
        new Surface([-2,1],[2,1]),
        #new Surface([-1,0],[2,0])
    ]
    cameraViewAngle = 2 * Math.atan(2.1 * Math.sqrt(2)  / 14)
    cameras = [
        #new CameraProjector([0, -10], [0,0], cameraViewAngle),
        new Camera([0, -10], [0,0], cameraViewAngle, 'Camera 1')
            .stripes([
                [0, 0.1, 0.2],
                [0.2, 0.3, 0.2],
                [0.4, 0.5, 0.2],
                [0.6, 0.7, 0.2],
                [0.8, 0.9, 0.2]
            ]),
        new Camera([-5, -10], [0,0], cameraViewAngle, 'Camera 2')
            .stripes([
                [0, 1, 1]
            ])
        #new Viewer([-12, -10], [0, 0], cameraViewAngle)
    ]

    cameras[1].projectorOn = false

    scene = {
        surfaces : surfaces,
        cameras : cameras
    }

    window.camera = cameras[0]

    for camera in scene.cameras
      camera.calculateMapping(scene.surfaces)

    updateLighting = ->
        for surface in scene.surfaces
            surface.resetIllumination()
        for camera in scene.cameras
            camera.castLight()

        cameras[0].lightLevelSeen()

    updateLighting()

    sceneComponent = SceneComponent().size(400)

    #draw the view from one camera
    d3.select('svg#scene').datum(scene).each(sceneComponent)

    sceneComponent.on 'cameraChange', ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    hub.on 'cameraChange', ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    drawViews(d3.select('#views'), scene)


    d3.select('#whatDoYouSee').on 'click', =>
        cameras[0].lightLevelSeen()
    

