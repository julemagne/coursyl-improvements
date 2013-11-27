class window.TreeHandler

  # --------------------------------
  # Node modal popups

  $(document).on "mouseenter", "g.node", ->
    TreeHandler.makeModal(this)
    TreeHandler.colorNodes(this.id)

  $(document).on "mouseenter", "tr.node", ->
    heldat = this.getAttribute("heldat")
    node = $("##{heldat}")
    if typeof node.get(0) != 'undefined'
      TreeHandler.makeModal(node.get(0))
    TreeHandler.colorNodes(heldat)

  $(document).on "mouseleave", "g.node, tr.node", ->
    TreeHandler.resetTree()

  $(document).scroll ->
    TreeHandler.resetTree()

  @makeModal: (node) ->
    modalheight = 130
    modalwidth = 300
    treepadding = 40

    treetop = $("#lesson-tree").offset().top
    treeleft = $("#lesson-tree").offset().left
    nodex = parseInt(node.getAttribute("nodex"))
    nodey = parseInt(node.getAttribute("nodey"))

    $('main').append('<div class="node-modal"></div>')
    modal = $('.node-modal')
    modal.append("<blockquote><p class='lead'>#{node.getAttribute("nodename")}</p></blockquote")
    modal.append("<small>#{node.getAttribute("nodedesc")}</small>")
    modal.css
      height: modalheight
      width: modalwidth
      top: treetop + nodey - modalheight - 18
      left: Math.min.apply(null, [$(window).width() - modalwidth - 30,
        Math.max.apply(null, [10, treeleft + nodex - modalwidth*0.5 + treepadding])])

    $('main').append('<div class="node-pointer"></div>')
    pointer = $('.node-pointer')
    pointer.css
      top: treetop + nodey + 2
      left: treeleft + nodex + treepadding - 2

  @resetTree: ->
    if $('.node-modal').length > 0
      $('.node-modal').remove()
      $('.node-pointer').remove()
      TreeHandler.colorNodesToPresent()


  # --------------------------------
  # Node coloring

  @colorNodes: (heldat, completed=false) ->
    circles = $('circle.node-dot, circle.node-dot-completed, circle.node-dot-empty')
    circles.each ->
      if parseInt(this.parentNode.getAttribute("id")) > parseInt(heldat)
        this.setAttribute("class", "node-dot-empty")
      else
        this.setAttribute("class", "node-dot#{if completed then "-completed" else ""}")

  @colorNodesToPresent: ->
    TreeHandler.colorNodes(jQuery.now() * 0.001, true)