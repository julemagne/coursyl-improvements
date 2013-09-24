window.TreeGenerator =
  visit: (parent, visitFn, childrenFn) ->
    return if !parent
    visitFn(parent)
    children = childrenFn(parent)
    if !!children
      for child in children
        visit(child, visitFn, childrenFn)

  buildTree: (treeData, containerName, customOptions) ->
      # Build the options object
      options = $.extend
        nodeRadius: 5
        sidePadding: 30
      , customOptions

      # Size of the diagram
      size =
        width: $(containerName).width()
        height: $(containerName).height()

      tree = d3.layout.tree()
        .sort(null)
        .size([size.height, size.width - options.sidePadding*2])
        .children (d) ->
          if !d.contents || d.contents.length == 0
            return null
          else
            return d.contents

      nodes = tree.nodes(treeData)
      links = tree.links(nodes)

      layoutRoot = d3.select(containerName)
        .append("svg:svg").attr("width", size.width).attr("height", size.height)
        .append("svg:g")
        .attr("class", "container")
        .attr("transform", "translate(" + options.sidePadding + ",0)")

      link = d3.svg.diagonal()
        .projection (d) ->
          return [d.y, d.x]

      layoutRoot.selectAll("path.link")
        .data(links)
        .enter()
        .append("svg:path")
        .attr("class", "link")
        .attr("d", link)

      nodeGroup = layoutRoot.selectAll("g.node")
          .data(nodes)
          .enter()
          .append("svg:g")
          .attr("class", "node")
          .attr("transform", (d) ->
            return "translate(" + d.y + "," + d.x + ")"
          )
          .attr("nodex", (d) -> return d.y)
          .attr("nodey", (d) -> return d.x)
          .attr("nodename", (d) -> return d.name)
          .attr("nodedesc", (d) -> return d.description)
          .attr("id", (d) -> return d.heldat)

      nodeGroup.append("svg:circle")
        .attr("class", "node-dot-empty")
        .attr("r", options.nodeRadius)