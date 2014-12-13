define (require) ->

    intersection = require('cs!intersection')
    Camera = require('cs!Camera')
    d3 = require('d3')

    describe 'intersection', ->

        it 'calculates the line for a view line coming out of a camera', ->
            camera = new Camera(0, 0, 0, null)
            line = intersection.cameraViewLineToCartesianLine(camera, 0)
            [p1, p2] = line
            expect(p1).toEqual([0,0])
            expect(p2).toEqual([0,10])


        it 'calculates the line for a view line coming out of a camera again', ->
            camera = new Camera(0, 0, Math.PI / 4, null)
            line = intersection.cameraViewLineToCartesianLine(camera, 0)
            [p1, p2] = line
            expect(p1).toEqual([0,0])
            [x,y] = p2
            side = d3.round(10 / Math.sqrt(2), 2)
            expect(d3.round(y, 2)).toEqual(side)
            expect(d3.round(x, 2)).toEqual(side)


        it 'calculates where two lines defined by end points will intersect', ->
            surface1 = [[-1,0], [1,2]]
            surface2 = [[0,0], [0,2]]
            point = intersection.cartesianCartesian(surface1, surface2)
            expect(point).toEqual([0,1])


        it 'does not make a difference which order the cartesianCartesian arguments are', ->
            surface1 = [[-1,0], [1,2]]
            surface2 = [[0,0], [0,2]]
            point = intersection.cartesianCartesian(surface2, surface1)
            expect(point).toEqual([0,1])


        it 'works with a vertical line which is not up the y axis', ->
            surface1 = [[-1,0], [1,2]]
            surface2 = [[2,0], [2,2]]
            point = intersection.cartesianCartesian(surface2, surface1)
            expect(point).toEqual([2,3])


        # it 'calculates where camera view lines will intersect with surfaces', ->
        #     surface = [[-1,0], [1,2]]
        #     camera = new Camera(0, 0, 0, null)
        #     point = intersection.cameraViewLineSurface(camera, 0, surface)
        #     expect(point).toEqual([0,1])






