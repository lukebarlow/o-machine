define (require) ->

    Camera = require('cs!Camera')

    class Viewer extends Camera

        drawWithCircle : true
        hasProjector : false

        # viewer casts no light
        castLight: =>
            return

