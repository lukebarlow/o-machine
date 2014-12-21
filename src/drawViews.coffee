define (require) ->

    #ViewComponent = require('cs!drawing/view')

    width = 300
    height = 120

    x = d3.scale.linear().domain([0,1]).range([0, width])

    colour = d3.scale.linear().domain([0,2]).range(['#000000','#ffffff'])

    return (div, scene) ->

        views = div.selectAll('svg')
            .data(scene.cameras)
            .enter()
            .append('svg')
            .attr('class','view')
            .attr('width', width)
            .attr('height', height)

        views.each (camera) ->
            svg = d3.select(this)
            svg.selectAll('rect')
                .data(camera.mappings.mappings)
                .enter()
                .append('rect')
                .attr('x', (m) -> x(m.screenDomain[0]))
                .attr('width', (m) -> x(m.screenDomain[1]) - x(m.screenDomain[0]))
                .attr('y', 0)
                .attr('height', height)
                .style('fill', (m) ->  colour(m.surface.illumination))