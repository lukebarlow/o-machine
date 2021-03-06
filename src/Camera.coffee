define (require) ->

    uid = require('cs!uid')
    surfaceMapping = require('cs!surfaceMapping')
    halfCirclePlusMinus = require('cs!halfCirclePlusMinus')
    Stripes = require('cs!Stripes')
    addProperties = require('cs!addProperties')
    hub = require('cs!hub')

    class Camera

        _hasProjector: true
        _useWaves: false
        _waves: []


        constructor: (position, pointsAt, viewAngle, name) ->
            addProperties(this, ['useWaves', 'hasProjector', 'waves'])
            this.position = position
            this.pointsAt = pointsAt
            this.calculateFacingAngle()
            this.viewAngle = viewAngle
            this.viewLines = []
            this._stripes = null
            this.projectorOn = true
            this.name = name
            hub.on 'tick.camera' + name, =>
                this._tick()


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


        # shortcut for setting stripes in a less verbose way
        stripes: (stripes) =>
            if not arguments.length
                if this._useWaves
                    return this._wavesAsStripes().stripes()
                else
                    return this._stripes.stripes()
            this._stripes = s = new Stripes()
            for stripe in stripes
                s.addStripe(stripe)
            return this


        castLight: =>
            if this.projectorOn
                s = if this._useWaves then this._wavesAsStripes() else this._stripes
                this.mappings.setStripedProjection(s)
            else
                # else just set to null stripes
                this.mappings.setStripedProjection(new Stripes())
            this.mappings.castLight()


        _wavesAsStripes: =>
            s = new Stripes()
            for wave in this._waves
                inner = Math.min(Math.max(0, wave.position - wave.thickness), 0.5)
                outer = Math.min(0.5, wave.position)
                s.addStripe([0.5 + inner, 0.5 + outer, wave.brightness, wave.colour])
                s.addStripe([0.5 - outer, 0.5 - inner, wave.brightness, wave.colour])
            return s


        _tick: =>
            #console.log('tick')
            if not this._useWaves
                return
            for wave in this._waves
                #console.log('wave', wave)
                elapsed = new Date() - wave.startTime
                wave.position = elapsed / 1000 * wave.speed
                #console.log('wave.position', wave.position)
            this._waves = this._waves.filter (wave) ->
                wave.position - wave.thickness <= 0.5


        lightLevelSeen: =>
            total = 0
            # iterate through the mappings to surfaces seen
            for m in this.mappings.mappings
                screenWidth = m.screenDomain[1] - m.screenDomain[0]
                t = d3.sum m.surface.stripes.stripes(), ([s, e, b]) =>
                    (e - s) * Math.min(b, 1)
                total += t * screenWidth
            return total


        startWave: (speed = 0.02, thickness = 0.05, brightness = 0.3, colour = [255, 255, 255]) =>
            if this.waveSpeed
                speed = this.waveSpeed
            # if this.colour
            #     colour = this.colour
            this._waves.push({
                position: 0,
                speed: speed,
                thickness: thickness,
                brightness: brightness,
                startTime: new Date(),
                colour: colour
            })





