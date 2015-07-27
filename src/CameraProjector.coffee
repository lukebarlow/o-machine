define (require) ->

    Camera = require('cs!Camera')

    class CameraProjector extends Camera

        _projectionMappings: null


        projectionMappings: (projectionMappings) ->
            if not arguments.length then return this._projectionMappings
            this._projectionMappings = projectionMappings
            return this


        castLight: ->
            this.mappings.castLight()