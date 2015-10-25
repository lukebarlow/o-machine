define (require) ->
    ''' 
    for each cameraProjector in the scene, it draws what is projected 
    and what is scene.
    '''

    hub = require('cs!hub')
    #ViewComponent = require('cs!drawing/view')

    width = 200
    height = 120

    x = d3.scale.linear().domain([0,1]).range([0, width])#.clamp(true)

    colour = d3.scale.linear().domain([0,2]).range(['#000000','#ffffff'])

    return (div, scene) ->

        views = div.selectAll('svg')
            .data(scene.cameras)
            .enter()
            .append('svg')
            .attr('class','view')
            .attr('width', width * 2 + 150)
            .attr('height', height + 4)
            .append('g')
            .attr('transform', 'translate(2,2)')

        projectionScale = d3.scale.linear().range([0, width])

        views.each (camera, i) ->
            svg = d3.select(this)
            
            svg.append('text')
                .attr('x', 100)
                .attr('y', height / 2)
                .attr('class', 'name')
                .attr('text-anchor', 'end')
                .text(camera.name)

            if camera.hasProjector

                svg.append('text')
                    .attr('x', 70)
                    .attr('y', height / 2 + 20)
                    .attr('class', 'name')
                    .attr('text-anchor', 'end')
                    .text('projector : ')

                svg.append('text')
                    .attr('x', 75)
                    .attr('y', height / 2 + 20)
                    .attr('class', 'button')
                    .attr('text-anchor', 'start')
                    .classed('off', !camera.projectorOn)
                    .text(if camera.projectorOn then 'ON' else 'OFF')
                    .on 'click', =>
                        camera.projectorOn = !camera.projectorOn
                        hub.cameraChange()

                ### draw what is projected by the projector ###
                gProjected = svg.append('g')
                    .attr('class', 'projected')
                    .attr('transform', 'translate(120,0)')

                # outline
                gProjected.append('rect')
                    .attr('class', 'outline')
                    .attr('x', -1)
                    .attr('y', -1)
                    .attr('width', width + 2)
                    .attr('height', height + 2)

                # the projected stripes of light
                gProjected.selectAll('g.lightStripe')
                    .data(camera.stripes())
                    .enter()
                    .append('rect')
                    .attr('class', 'lightStripe')
                    .attr('x', ([s, e, b]) -> projectionScale(s))
                    .attr('width', ([s, e, b]) -> projectionScale(e) - projectionScale(s))
                    .attr('y', 0)
                    .attr('height', height)
                    .style('opacity', ([s, e, b]) -> b)


            ### draw what is seen by the camera ###

            # we define a clip path to avoid the camera view spilling beyond
            # it's bounds

            id = 'cp-' + i

            clipPath = svg.append('defs')
                .append('clipPath')
                .attr('id', id)
                .append('rect')
                .attr('width', width)
                .attr('height', height)

            gSeen = svg.append('g')
                .attr('class', 'seen')
                .attr('transform', "translate(#{width+135}, 0)")
                
            gSeen.append('rect')
                .attr('class', 'outline')
                .attr('x', -1)
                .attr('y', -1)
                .attr('width', width + 2)
                .attr('height', height + 2)

            contents = gSeen.append('g')
                .style('clip-path', 'url(#' + id + ')')

            contents.selectAll('rect.surfaceBackground')
                .data(camera.mappings.mappings)
                .enter()
                .append('rect')
                .attr('class', 'surfaceBackground')
                .attr('x', (m) -> x(m.screenDomain[0]))
                .attr('width', (m) -> x(m.screenDomain[1]) - x(m.screenDomain[0]))
                .attr('y', 0)
                .attr('height', height)

            contents.selectAll('rect.surface')
                .data(camera.mappings.mappings)
                .enter()
                .append('rect')
                .attr('class', 'surface')
                .attr('x', (m) -> x(m.screenDomain[0]))
                .attr('width', (m) -> x(m.screenDomain[1]) - x(m.screenDomain[0]))
                .attr('y', 0)
                .attr('height', height)

            g = contents.selectAll('g.mapping')
                .data(camera.mappings.mappings)
                .enter()
                .append('g')
                .attr('class', 'mapping')
                .attr('transform', (mapping) -> "translate(#{x(mapping.screenDomain[0])},0)")

            g.each (mapping) ->
                group = d3.select(this)
                surfaceWidth = x(mapping.screenDomain[1]) - x(mapping.screenDomain[0])
                mappingScale = d3.scale.linear().range([0, surfaceWidth]).clamp(true)
                #console.log('drawViews', mapping)

                #console.log('drawing mapping')
                #console.log(mapping.surface.stripes.stripes())

                group.selectAll('rect')
                    .data(mapping.surface.stripes.stripes())
                    .enter()
                    .append('rect')
                    .attr('class', 'lightStripe')
                    .attr('x', ([s, e, b]) -> mappingScale(s))
                    .attr('width', ([s, e, b]) -> mappingScale(e) - mappingScale(s))
                    .attr('y', 0)
                    .attr('height', height)
                    .style('opacity', ([s, e, b]) -> b)

            
            # rect = g.selectAll('rect')
            #     .data((mappings) -> mappings.stripes.stripes())
            #     .enter()
            #     .append('rect')
