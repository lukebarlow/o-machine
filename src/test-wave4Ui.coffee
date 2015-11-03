define (require) ->

    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
    hub = require('cs!hub')
   
    surfaces = require('cs!scenes/oMachineSurfaces')
    cameras = require('cs!scenes/oMachineCamerasAndViewer')

    for camera in cameras.slice(1)
        camera.useWaves(true)

    # cameras[1].waveSpeed = 0.025
    # cameras[2].waveSpeed = 0.026
    # cameras[3].waveSpeed = 0.025
    # cameras[4].waveSpeed = 0.025

    # cameras[1].colour = [255, 0, 0]
    # cameras[2].colour = [0, 255, 0]
    # cameras[3].colour = [0, 0, 255]
    # cameras[4].colour = [255, 255, 0]

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

        for camera in cameras.slice(1)
            delay = new Date() - (camera.lastWave or 0)
            if delay > 3000
                camera.lastWave = new Date()
                b = camera.lightLevelSeen()
                # if b < 0.25
                #     camera.startWave(null, thickness = 0.04 + Math.random() * 0.02, brightness = b + 0.5)
                # else
                #     camera.startWave(null, thickness = 0.04 + Math.random() * 0.02, brightness = 1 - b)
                if b < 0.26
                    camera.startWave(speed = 0.01 + Math.random() * 0.02, thickness = 0.2 + Math.random() * 0.03, brightness = 1, colour = [0, 0, 150])
                else if b < 0.4
                    camera.startWave(speed = 0.02, thickness = 0.05, brightness = 0.2, colour = [255, 255, 255])
                else if b < 0.46
                    camera.startWave(speed = 0.03, thickness = 0.02, brightness = 1, colour = [255, 0, 0])
                else if b < 0.48
                    camera.startWave(speed = 0.04, thickness = 0.1, brightness = 0.6, colour = [0, 255, 0])
                else if b < 0.49
                    camera.startWave(speed = 0.08, thickness = 0.02, brightness = 1, colour = [255, 255, 255])
                else
                    camera.startWave(speed = 0.03, thickness = 0.01, brightness = 1, colour = [255, 0, 0])
                



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

    setInterval(hub.tick, 20)
    hub.on('tick', cameraChange)

