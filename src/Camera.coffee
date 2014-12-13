define (require) ->

    uid = require('cs!uid')
    surfaceMapping = require('cs!surfaceMapping')
    halfCirclePlusMinus = require('cs!halfCirclePlusMinus')

    class Camera

        constructor: (position, pointsAt, viewAngle) ->
            this.position = position
            this.pointsAt = pointsAt
            this.calculateFacingAngle()
            this.viewAngle = viewAngle
            this.viewLines = []


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
            this.facingAngle = halfCirclePlusMinus(Math.atan2(dx, dy), (2 * Math.PI))