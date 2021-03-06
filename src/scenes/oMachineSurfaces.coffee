define (require) ->

    Surface = require('cs!Surface')

    pillarWidth = 0.6

    ###
    The pillars are organised around the 0,0 point in the centre. The positions
    are given in units of [width of pillar] here, and then converted into
    metres when we calculate the positions of the surfaces
    ###

    pillars = [
        # along the top
        [-3.5, 2.5],
        [-1.5, 2.5],
        [0.5, 2.5],
        [2.5, 2.5],

        # left hand side
        [-3.5, 0.5],
        [-3.5, -1.5],

        # right hand side
        [2.5, 0.5],
        [2.5, -1.5],

        # bottom
        [-3.5, -3.5],
        [-1.5, -3.5],
        [0.5, -3.5],
        [2.5, -3.5],
    ]

    surfaces = []
    for [x, y] in pillars
        x *= pillarWidth
        y *= pillarWidth
        surfaces = surfaces.concat([
            [[x,y],[x,y + pillarWidth]],
            [[x,y + pillarWidth], [x + pillarWidth, y + pillarWidth]],
            [[x + pillarWidth, y + pillarWidth],[x + pillarWidth, y]],
            [[x + pillarWidth, y], [x,y]]
        ])

    surfaces = surfaces.map(([p1, p2]) -> new Surface(p1, p2))

    return surfaces