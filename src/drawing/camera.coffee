define (require) ->

    return ->
        x = null
        y = null

        viewLineLength = Math.sqrt(14 * 14 + 2.1 * 2.1) + 0.1

        dispatch = d3.dispatch('change')

        radiansToDegrees = (angle) ->
            return angle / Math.PI * 180

        camera = (c) ->

            pixelViewLineLength = x(viewLineLength) - x(0)

            pixelLength = (distance) ->
                return x(distance) - x(0)

            translate = -> "translate(#{x(c.position[0])},#{y(c.position[1])})"

            rotate = -> "rotate(#{radiansToDegrees(c.facingAngle)})"

            parent = d3.select(this)
            parent.attr('transform', translate)

            g = parent.append('g').attr('transform', rotate)

            g.append('rect')
                .attr('x', -10)
                .attr('y', -15)
                .attr('width', 20)
                .attr('height', 30)

            g.append('line')
                .attr('x1', 0)
                .attr('y1', 0)
                .attr('x2', 0 - Math.sin(c.viewAngle / 2) * pixelViewLineLength)
                .attr('y2', 0 - Math.cos(c.viewAngle / 2) * pixelViewLineLength)

            g.append('line')
                .attr('x1', 0)
                .attr('y1', 0)
                .attr('x2', 0 + Math.sin(c.viewAngle / 2) * pixelViewLineLength)
                .attr('y2', 0 - Math.cos(c.viewAngle / 2) * pixelViewLineLength)

            g.selectAll('line.viewLine')
                .data(c.viewLines)
                .enter()
                .append('line')
                .attr('class','viewLine')
                .style('stroke','white')
                .attr('x2', (d) -> 0 + Math.sin(d.angle) * pixelLength(d.length))
                .attr('y2', (d) -> 0 - Math.cos(d.angle) * pixelLength(d.length))


            dragmove = (c) ->
                dx = x.invert(d3.event.dx) - x.invert(0)
                dy = y.invert(d3.event.dy) - y.invert(0)
                c.position[0] += dx
                c.position[1] += dy
                
                c.calculateFacingAngle()
                parent = d3.select(this)

                parent.attr('transform', translate)
                
                g = parent.select('g').attr('transform', rotate)

                c.calculateMapping()

                s = g.selectAll('line.viewLine').data(c.viewLines)

                s.attr('stroke','white')
                    .attr('x2', (d) -> 0 + Math.sin(d.angle) * pixelLength(d.length))
                    .attr('y2', (d) -> 0 - Math.cos(d.angle) * pixelLength(d.length))

                s.enter()
                    .append('line')
                    .attr('class','viewLine')
                    .style('stroke','white')
                    .attr('x2', (d) -> 0 + Math.sin(d.angle) * pixelLength(d.length))
                    .attr('y2', (d) -> 0 - Math.cos(d.angle) * pixelLength(d.length))

                s.exit().remove()

                dispatch.change()


            drag = d3.behavior.drag()
                .on('drag', dragmove)

            parent.call(drag)


        camera.x = (_x) ->
            if not arguments.length then return x
            x = _x
            return camera


        camera.y = (_y) ->
            if not arguments.length then return y
            y = _y
            return camera


        camera.on = (type, handler) ->
            dispatch.on(type, handler)
            return camera


        return camera
