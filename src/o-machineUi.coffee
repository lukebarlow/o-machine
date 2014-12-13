define (require) ->

    scene = require('cs!scene')
    SceneComponent = require('cs!drawing/scene')
    drawViews = require('cs!drawViews')
    view = require('cs!view')
   

    for camera in scene.cameras
      camera.calculateMapping(scene.surfaces)

    sceneComponent = SceneComponent()

    #draw the view from one camera
    d3.select('svg#scene').datum(scene).each(sceneComponent)

    # sceneComponent.on 'cameraChange', ->
    #     console.log('got a camera change')

    drawViews(d3.select('#views'), scene)

