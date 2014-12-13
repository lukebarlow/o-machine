define (require) ->

    line = require('cs!line')

    describe 'line', ->

        it 'calculates a and b for line in form y = ax + b, given two points', ->
            expect(line([1,1],[2,2])).toEqual([1,0])
            expect(line([1,1],[3,2])).toEqual([0.5,0.5])


        it 'returns a = Infinity and b = NaN if the line is vertical', ->
            expect(line([0,0],[0,1])).toEqual([Infinity, NaN])

