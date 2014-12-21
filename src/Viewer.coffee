define (require) ->

    Camera = require('cs!Camera')

    class Viewer extends Camera

        drawWithCircle : true
        hasProjector : false

