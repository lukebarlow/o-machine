define (require) ->

    Viewer = require('cs!Viewer')
    CameraProjector = require('cs!CameraProjector')
    Camera = require('cs!Camera')
    Surface = require('cs!Surface')
    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
    hub = require('cs!hub')
   
    # surfaces = [
    #     new Surface([-2,3],[5,3]),
    #     #new Surface([-1,0],[2,0])
    # ]
    # cameraViewAngle = 2 * Math.atan(2.1 * Math.sqrt(2)  / 14)
    # cameras = [
    #     new Camera([0, -13], [0,0], cameraViewAngle, 'Camera 1')
    #         .useWaves(true),
    #     new Camera([3, -10], [3,0], cameraViewAngle, 'Camera 2')
    #         .useWaves(true),
    #     new Viewer([-5, -10], [0,0], cameraViewAngle, 'Viewer')
    # ]

    surfaces = require('cs!scenes/oMachineSurfaces')
    cameras = require('cs!scenes/oMachineCamerasAndViewer')

    for camera in cameras.slice(1)
        camera.useWaves(true)

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

    updateLighting()

    sceneComponent = SceneComponent().size(400)

    #draw the view from one camera
    d3.select('svg#scene').datum(scene).each(sceneComponent)

    cameraChange = ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    sceneComponent.on('cameraChange', cameraChange)
    hub.on('cameraChange', cameraChange)

    drawViews(d3.select('#views'), scene)

    d3.select('#makeWave').on 'click', =>
        cameras[1].startWave()

    d3.select('#makeWave2').on 'click', =>
        cameras[2].startWave()

    d3.select('#makeWave3').on 'click', =>
        cameras[3].startWave()

    d3.select('#makeWave4').on 'click', =>
        cameras[4].startWave()

    #d3.timer(hub.tick)
    setInterval(hub.tick, 10)

    hub.on('tick', cameraChange)

