define (require) ->

    overlap = require('cs!overlap')

    describe 'overlap', ->

        it 'knows if domains do not overlap at all', ->
            expect(overlap([1,2],[3,4])).toEqual('no overlap')

        it 'calculates if the first domain completely contains the second', ->
            expect(overlap([1,4],[2,3])).toEqual('contains')

        it 'calculates if the first domain is completely inside the second', ->
            expect(overlap([2,3],[1,4])).toEqual('inside')

        it 'calculates if the first overlaps the left portion of the second', ->
            expect(overlap([1,3],[2,4])).toEqual('overlap left')

        it 'calculates if the first overlaps the right portion of the second', ->
            expect(overlap([2,4],[1,3])).toEqual('overlap right')

        it 'if right edge is shared but the rest is inside, then it should be inside', ->
            expect(overlap([2,3],[1,3])).toEqual('inside')

        it 'if left edge is shared but the rest is inside, then it should be inside', ->
            expect(overlap([1,2],[1,3])).toEqual('inside')

        it 'left edge is shared and the rest is outisde, then it should be contains', ->
            expect(overlap([1,3],[1,2])).toEqual('contains')

        it 'right edge is shared and the rest is outisde, then it should be contains', ->
            expect(overlap([1,3],[2,3])).toEqual('contains')

