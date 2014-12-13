# given two domains, returns information about how they overlap
# possible return values are
# 'inside', 'no overlap', 'contains', 'overlap left', 'overlap right'

define (require) ->

    between = (value, [start, end]) ->
            return value >= start and value <= end

    return (domain1, domain2) ->
        [start1, end1] = domain1
        [start2, end2] = domain2
        
        if between(start2, domain1) and between(end2, domain1)
            return 'contains'

        startIsInside = between(start1, domain2)
        endIsInside = between(end1, domain2)

        if startIsInside and endIsInside
            return 'inside'
        if not startIsInside and not endIsInside
            return 'no overlap'
        if endIsInside and not startIsInside
            return 'overlap left'
        if startIsInside and not endIsInside
            return 'overlap right'
        throw 'Something wrong with overlap function. Could not categorise'
