define (require) ->

    overlap = require('cs!overlap')

    ###
    This class keeps track of a set of stripes of various brightness. 
    This is used either for the stripes projected by a projector 
    (subclass ProjectorStripes) or the stripes of light on a particular surface 
    (subclass SurfaceStripes)

    The domain used for stripe position by this class will always be [0, 1] 
    and the brightness level of each stripe is also given between 0 and 1.
    So each stripe is a start and end angle and a brightness in a three element
    array [start, end, brightness]

    So, for example, here are three stripes of white, grey, black.

    [
        [0, 0.2, 1],
        [0.2 0.5, 0.5],
        [0.5, 1, 0]
    ]

    Note that the format is slightly redundant, because the end of one stripe
    must always be the same as the start of the next stripe. It is possible
    to have overlapping stripes and then 'normalise' them to this non
    overlapping form.


    ###
    class Stripes


        constructor: ->
            this._stripes = []


        addStripe: (stripe) =>
            this._stripes.push(stripe)
            return this


        addStripes: (stripes) =>
            if stripes
                this._stripes = this._stripes.concat(stripes._stripes)


        # converts a collection of possibly overlapping stripes into
        # a non overlapping set
        normalise: =>
            # first find all the points in the domain where the brightness
            # might change, and get these as a sorted list of numbers
            lineSet = new Set([0, 1])
            for [start, end, brightness] in this._stripes
                lineSet.add(start)
                lineSet.add(end)
            lines = []
            lineSet.forEach (line) ->
                lines.push(line)
            lines.sort()

            # now go through each region in this list, and sum the brightness
            # of stripes which are contributing to it
            result = []
            previous = 0
            for line in lines.slice(1)
                b = 0
                for [start, end, brightness] in this._stripes
                    if (start <= previous) and (end >= line)
                        b += brightness
                result.push([previous, line, b])
                previous = line

            this._stripes = result
            return this


        # returns a new Stripes object, which is just a slice of this
        # stripes object defined by the current domain
        slice: (domain) =>
            result = new Stripes()
            # scale s converts from the slice domain to the new [0, 1] domain
            s = d3.scale.linear().domain(domain).range([0,1])
            for [start, end, brightness] in this._stripes
                switch overlap([start, end], domain)
                    when 'inside'
                        result.addStripe([s(start), s(end), brightness])
                    when 'contains'
                        result.addStripe([0, 1, brightness])
                    when 'overlap left'
                        result.addStripe([0, s(end), brightness])
                    when 'overlap right'
                        result.addStripe([s(start), 1, brightness])
            return result


        stripes: (stripes) =>
            if not arguments.length
                this.normalise()
                return this._stripes
            this._stripes = stripes
            return this



    