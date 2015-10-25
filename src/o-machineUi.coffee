define (require) ->

    scene = require('cs!scenes/oMachineScene')
    SceneComponent = require('cs!drawing/scene')
    Stripes = require('cs!Stripes')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
    hub = require('cs!hub')
   
    for camera in scene.cameras
      camera.calculateMapping(scene.surfaces)

    updateLighting = ->
        for surface in scene.surfaces
            surface.resetIllumination()

        for camera in scene.cameras
            camera.castLight()

    updateLighting()

    sceneComponent = SceneComponent()

    #draw the view from one camera
    d3.select('svg#scene').datum(scene).each(sceneComponent)

    sceneComponent.on 'cameraChange', ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    hub.on 'cameraChange', ->
        updateLighting()
        drawViews(d3.select('#views').html(''), scene)

    drawViews(d3.select('#views'), scene)

