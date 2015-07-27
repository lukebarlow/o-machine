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
            
                #.style('fill', (m) ->  colour(m.surface.illumination))

            svg.selectAll('rect.surfaceBackground')
                .data(camera.mappings.mappings)
                .enter()
                .append('rect')
                .attr('class', 'surfaceBackground')
                .attr('x', (m) -> x(m.screenDomain[0]))
                .attr('width', (m) -> x(m.screenDomain[1]) - x(m.screenDomain[0]))
                .attr('y', 0)
                .attr('height', height)

            g = svg.selectAll('g.mapping')
                .data(camera.mappings.mappings)
                .enter()
                .append('g')
                .attr('class', 'mapping')
                .attr('transform', (mapping) -> "translate(#{x(mapping.screenDomain[0])},0)")

            g.each (mapping) ->
                group = d3.select(this)
                surfaceWidth = x(mapping.screenDomain[1]) - x(mapping.screenDomain[0])
                mappingScale = d3.scale.linear().range([0, surfaceWidth])
                #console.log('drawViews', mapping)

                group.selectAll('rect')
                    .data(mapping.surface.stripes.stripes())
                    .enter()
                    .append('rect')
                    .attr('class', 'lightStripe')
                    .attr('x', ([s, e, b]) -> mappingScale(s))
                    .attr('width', ([s, e, b]) -> mappingScale(e) - mappingScale(s))
                    .attr('y', 0)
                    .attr('height', height)
                    #.style('fill', ([s, e, b]) -> colour(b))
                    .style('opacity', ([s, e, b]) -> b)

            svg.selectAll('rect.surface')
                .data(camera.mappings.mappings)
                .enter()
                .append('rect')
                .attr('class', 'surface')
                .attr('x', (m) -> x(m.screenDomain[0]))
                .attr('width', (m) -> x(m.screenDomain[1]) - x(m.screenDomain[0]))
                .attr('y', 0)
                .attr('height', height)



            # rect = g.selectAll('rect')
            #     .data((mappings) -> mappings.stripes.stripes())
            #     .enter()
            #     .append('rect')
