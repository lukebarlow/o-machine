# keeps track of the mappings of what a camera can see

define (require) ->

    overlap = require('cs!overlap')
    intersection = require('cs!intersection')
    distance = require('cs!distance')

    class Mappings

        constructor: (camera) ->
            this.camera = camera
            this.mappings = []

        
        addMapping: (angularDomain, surface) ->
            
            # by looking a the angle ranges already covered,
            # figure out if this new angle is fully visible,
            # fully not visible or partially visible

            # switch lines if they are in the wrong order.
            # TODO! this comparison will not work at all points
            # on the circle
            [start, end] = angularDomain
            if start > end
                [start, end] = [end, start]
                angularDomain = [start, end]

            for mapping in this.mappings

                [mappingStart, mappingEnd] = mapping.angularDomain
                overlapping = overlap(angularDomain, mapping.angularDomain)
                
                #console.log('comparing to other mappings')
                #console.log(overlapping)

                switch overlapping
                    # surface is completely behind some other surface, so ignore
                    when 'inside' then return 
                    # will stick out at either side of another surface, so
                    # we calculate it as two parts and recursively add both
                    when 'contains'
                        this.addMapping([start, mappingStart], surface)
                        this.addMapping([mappingEnd, end], surface)
                        return
                    # if it overlaps the left, then we just reduce it down to
                    # what is visible
                    when 'overlap left'
                        [start, end] = [start, mappingStart]
                    when 'overlap right'
                        [start, end] = [mappingEnd, end]

            if end - start > 0.0001
                this.mappings.push({
                    angularDomain : [start, end],
                    surface : surface
                })


        # for each mapping calculate the length of the line until it hits
        # the surface
        calculateSurfaceIntersections: ->
            camera = this.camera
            for mapping in this.mappings
                [start, end] = mapping.angularDomain
                startIntersection = intersection.cameraViewLineSurface(this.camera, start, mapping.surface)
                endIntersection = intersection.cameraViewLineSurface(this.camera, end, mapping.surface)

                startLength = distance(startIntersection, camera.position)
                endLength = distance(endIntersection, camera.position)

                mapping.lengths = [startLength, endLength]


        sort: ->
            this.mappings.sort (a, b) ->
                a = a.angularDomain[0]
                b = b.angularDomain[0]
                return a - b


        setUniformProjection: (lightLevel) ->
            for mapping in this.mappings
                mapping.lightLevel = lightLevel


        castLight: ->
            for mapping in this.mappings
                mapping.surface.illumination += (mapping.lightLevel or 0)

