# create a Mappings object for what the specified camera can see
define (require) ->

    distanceAndAngle = require('cs!distanceAndAngle')
    distanceSort = require('cs!distanceSort')
    Mappings = require('cs!Mappings')
    halfCirclePlusMinus = require('cs!halfCirclePlusMinus')

    radToDegrees = (a) ->
        return a / Math.PI * 180

    viewLine = (point, camera) ->
        [length, absoluteAngle] = distanceAndAngle(point, camera.position)
        relativeAngle = halfCirclePlusMinus(absoluteAngle - camera.facingAngle)
        return {
            angle : relativeAngle, 
            length : length
        }

    # given a camera and some surfaces, it will
    # return a list of what surfaces are visible to the camera
    return (camera, surfaces) ->

        # copy surfaces and sort by distance from camera
        surfaces = surfaces.slice().sort(distanceSort(camera.position))

        mappings = new Mappings(camera)

        for surface in surfaces
            line1 = viewLine(surface.p1, camera)
            line2 = viewLine(surface.p2, camera)
            mappings.addMapping([line1.angle, line2.angle], surface)

        mappings.calculateSurfaceIntersections()
        
        for mapping in mappings.mappings
            [start, end] = mapping.angularDomain
            [startLength, endLength] = mapping.lengths
            camera.viewLines.push({
                angle : start,
                length : startLength
            })
            camera.viewLines.push({
                angle : end,
                length : endLength
            })

        mappings.sort()

        # figure out how the angles map to positions on the screen
        halfScreenWidth = Math.tan(camera.viewAngle / 2)

        screenMapping = d3.scale.linear()
            .domain([-halfScreenWidth, +halfScreenWidth])
            .range([0,1])

        screenPosition = (relativeAngle) ->
            return screenMapping(Math.atan(relativeAngle))

        for mapping in mappings.mappings
            mapping.screenDomain = mapping.angularDomain.map(screenPosition)

        mps = mappings.mappings

        return mappings