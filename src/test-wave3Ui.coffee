define (require) ->

    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
    hub = require('cs!hub')
   
    surfaces = require('cs!scenes/oMachineSurfaces')
    cameras = require('cs!scenes/oMachineCamerasAndViewer')

    for camera in cameras.slice(1)
        camera.useWaves(true)

    cameras[1].waveSpeed = 0.025
    cameras[2].waveSpeed = 0.025
    cameras[3].waveSpeed = 0.025
    cameras[4].waveSpeed = 0.025

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
            if delay > 2000
                b = camera.lightLevelSeen()
                # if b < 0.25
                #     camera.startWave(null, thickness = 0.04 + Math.random() * 0.02, brightness = b + 0.5)
                # else
                #     camera.startWave(null, thickness = 0.04 + Math.random() * 0.02, brightness = 1 - b)
                if b < 0.2
                    camera.startWave(null, thickness = 0.1 + Math.random() * 0.03, brightness = 0.7)
                else if b < 0.48
                    camera.startWave(null, thickness = 0.3, brightness = 0.02)
                else
                    camera.startWave(null, thickness = 0.04, brightness = 1)
                camera.lastWave = new Date()



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

