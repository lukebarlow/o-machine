define (require) ->

    Surface = require('cs!Surface')

    getSurface = -> new Surface([0,0],[5,0])


    describe 'Surface', ->

        it 'can add one section of light to illuminate the surface', ->
            s = getSurface()
            s.addIllumination([0,0.5], 1)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.5],
                    lightLevel : 1
                }
            ])

        it '''can add two non-overlapping sections of light to illuminate the 
        surface, and will sort them correctly''', ->
            s = getSurface()
            s.addIllumination([0.6,1], 1)
            s.addIllumination([0,0.5], 1)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.5],
                    lightLevel : 1
                },
                {
                    domain : [0.6, 1],
                    lightLevel : 1
                }
            ])

        it '''can add two sections with one shared edge, to end up with two
        areas of illumination''', ->
            s = getSurface()
            s.addIllumination([0, 1], 1)
            s.addIllumination([0.5, 1], 1)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.5],
                    lightLevel : 1
                },
                {
                    domain : [0.5, 1],
                    lightLevel : 2
                }
            ])

        it '''can add two regions, one inside the other, to end up with three
        areas of illumination''', ->
            s = getSurface()
            s.addIllumination([0, 1], 1)
            s.addIllumination([0.5, 0.6], 1)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.5],
                    lightLevel : 1
                },
                {
                    domain : [0.5, 0.6],
                    lightLevel : 2
                },
                {
                    domain : [0.6, 1],
                    lightLevel : 1
                }
            ])

        it '''can add the two regions in the opposite order and end up with
        the same result as the previous test''', ->
            s = getSurface()
            s.addIllumination([0.5, 0.6], 1)
            s.addIllumination([0, 1], 1)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.5],
                    lightLevel : 1
                },
                {
                    domain : [0.5, 0.6],
                    lightLevel : 2
                },
                {
                    domain : [0.6, 1],
                    lightLevel : 1
                }
            ])

        it '''can add add two overlapping regions to end up with 3 regions''', ->
            s = getSurface()
            s.addIllumination([0, 0.6], 1)
            s.addIllumination([0.4, 1], 0.5)
            expect(s.illumination).toEqual([
                {
                    domain : [0, 0.4],
                    lightLevel : 1
                },
                {
                    domain : [0.4, 0.6],
                    lightLevel : 1.5
                },
                {
                    domain : [0.6, 1],
                    lightLevel : 0.5
                }
            ])


        it '''can add add multiple regions of light which will all get added
        correctly''', ->
            s = getSurface()
            s.addIllumination([0, 0.6], 1)
            s.addIllumination([0.1, 0.7], 0.5)
            s.addIllumination([0.2, 0.8], 0.2)
            console.log(JSON.stringify(s.illumination, null, 4))
            expect(s.illumination).toEqual([
                {
                    domain: [0,0.1],
                    lightLevel: 1
                },
                {
                    domain: [0.1,0.2],
                    lightLevel: 1.5
                },
                {
                    domain: [0.2,0.6],
                    lightLevel: 1.7
                },
                {
                    domain: [0.6,0.7],
                    lightLevel: 0.7
                },
                {
                    domain: [0.7,0.8],
                    lightLevel: 0.2
                }
            ])




