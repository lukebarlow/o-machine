define (require) ->

    uid = require('cs!uid')

    class Surface

        constructor: (p1, p2) ->
            this.p1 = p1
            this.p2 = p2
            this.midpoint = [(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2]
            this.id = uid()
