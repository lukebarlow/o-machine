define (require) ->

    scene = require('cs!scene')
    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
   
    for camera in scene.cameras
      camera.calculateMapping(scene.surfaces)



    updateLighting = ->

        scene.cameras[0].setUniformProjection(0.5)
        scene.cameras[1].setUniformProjection(0.5)
        scene.cameras[2].setUniformProjection(0.5)
        scene.cameras[3].setUniformProjection(0.5)

        for surface in scene.surfaces
            surface.illumination = 0

        for camera in scene.cameras
            camera.castLight()

    updateLighting()

    sceneComponent = SceneComponent()

    #draw the view from one camera
    d3.select('svg#scene').datum(scene).each(sceneComponent)

    sceneComponent.on 'cameraChange', ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    drawViews(d3.select('#views'), scene)

