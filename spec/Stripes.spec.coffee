define (require) ->

    Stripes = require('cs!Stripes')
    d3 = require('d3')

    round = (value) -> 
        if Array.isArray(value)
            return value.map(round)
        return d3.round(value, 3)

    getStripes = -> 
        s = new Stripes()


    describe 'Stripes', ->

        describe 'normalise', ->

            it 'can add one section of light to illuminate the surface', ->
                s = getStripes()
                s.addStripe([0, 0.5, 1])
                
                expect(s.stripes()).toEqual([
                    [0, 0.5, 1],
                    [0.5, 1, 0]
                ])

            it 'can normalise more complex combinations of stripes', ->
                s = getStripes()
                s.addStripe([0, 1, 0.2])
                s.addStripe([0.2, 0.4, 0.2])
                s.addStripe([0.3, 0.5, 0.2])

                expect(round(s.stripes())).toEqual([
                    [0, 0.2, 0.2],
                    [0.2, 0.3, 0.4],
                    [0.3, 0.4, 0.6],
                    [0.4, 0.5, 0.4],
                    [0.5, 1, 0.2]
                ])


        describe 'slice', ->
            it 'can take a slice out of a set of stripes', ->
                s = getStripes()
                s.addStripe([0, 0.5, 1])
                slice = s.slice([0.4, 0.6])
                expect(slice.stripes()).toEqual([
                    [0, 0.5, 1],
                    [0.5, 1, 0]
                ])

            it 'can take a different slice out of a set of stripes', ->
                s = getStripes()
                s.addStripe([0, 0.5, 1])
                slice = s.slice([0.1, 0.6])
                expect(slice.stripes()).toEqual([
                    [0, 0.8, 1],
                    [0.8, 1, 0]
                ])

            it 'can take another different slice out of a set of stripes', ->
                s = getStripes()
                s.addStripe([0, 1, 0.2])
                s.addStripe([0.2, 0.4, 0.2])
                s.addStripe([0.3, 0.5, 0.2])
                slice = s.slice([0.3, 0.5])
                expect(round(slice.stripes())).toEqual([
                    [0, 0.5, 0.6],
                    [0.5, 1, 0.4]
                ])

