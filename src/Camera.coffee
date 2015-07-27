define (require) ->

    uid = require('cs!uid')
    surfaceMapping = require('cs!surfaceMapping')
    halfCirclePlusMinus = require('cs!halfCirclePlusMinus')
    Stripes = require('cs!Stripes')

    class Camera

        constructor: (position, pointsAt, viewAngle) ->
            this.position = position
            this.pointsAt = pointsAt
            this.calculateFacingAngle()
            this.viewAngle = viewAngle
            this.viewLines = []
            this._stripes = null


        calculateMapping: (surfaces) ->
            if not surfaces
                surfaces = this._surfaces
            else
                this._surfaces = surfaces
            this.viewLines = []
            this.mappings = surfaceMapping(this, surfaces)


        calculateFacingAngle: ->
            [px, py] = this.pointsAt
            dx = px - this.position[0]
            dy = py - this.position[1]
            this.facingAngle = halfCirclePlusMinus(Math.atan2(dx, dy))


        # setUniformProjection: (lightLevel) ->
        #     this.mappings.setUniformProjection(lightLevel)
        #     return this


        setStripedProjection: (stripes) =>
            this._stripes = stripes
            # if this.mappings
            #     this.mappings.setStripedProjection(stripes)
            return this

        # shortcut for setting stripes in a less verbose way
        stripes: (stripes) =>
            this._stripes = s = new Stripes()
            for stripe in stripes
                s.addStripe(stripe)
            return this


        castLight: =>
            this.mappings.setStripedProjection(this._stripes)
            this.mappings.castLight()