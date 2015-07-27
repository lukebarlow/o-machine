define (require) ->

    scene = require('cs!scenes/projectStripesScene')
    SceneComponent = require('cs!drawing/scene')
    Stripes = require('cs!Stripes')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
   
    for camera in scene.cameras
      camera.calculateMapping(scene.surfaces)

    updateLighting = ->

        # stripes = new Stripes()
        #     .addStripe([0, 0.5, 1])
        #     # .addStripe([0.2, 0.4, 1])
        #     # .addStripe([0.5, 1, 0.3])
        #     # .addStripe([0.6, 0.65, 1])

        # # _stripes = stripes.stripes()
        # # console.log('STRIPES', _stripes)

        # scene.cameras[0].setStripedProjection(stripes)

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

    drawViews(d3.select('#views'), scene)

