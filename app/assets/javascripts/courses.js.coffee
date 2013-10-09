# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# --------------------------------
# Sticky Tree
$(window).scroll ->
  tree = $("#lesson-tree")
  if tree.length > 0
    headeroffset = 190
    treewrapperheight = 190
    scrolltop = $(this).scrollTop()
    topposition = $("#lesson-tree-anchor").offset().top
    bottomposition = $("#lesson-bottom-anchor").offset().top

    if (scrolltop > topposition - headeroffset) and (scrolltop < bottomposition - (headeroffset+treewrapperheight))
      tree.css
        position: "fixed"
        top: "#{headeroffset}px"

    else
      if tree.css('position') is "fixed"
        if (scrolltop <= topposition - headeroffset)
          tree.css
            position: "relative"
            top: ""
        else
          tree.css
            position: "relative"
            top: "#{bottomposition-topposition-treewrapperheight}px"


# --------------------------------
# Smooth scrolling
$(document).on "click", ".smooth-nav a", ->
  $("html, body").animate
    scrollTop: $($.attr(this, "href")).offset().top
  , 700
  false


# --------------------------------
# Node modal popups
$(document).on "mouseenter", "g.node", ->
  resetTree()
  makeModal(this)
  colorNodes(this.id)

$(document).on "mouseenter", "tr.node", ->
  resetTree()
  heldat = this.getAttribute("heldat")
  node = $("##{heldat}")
  if typeof node.get(0) != 'undefined'
    makeModal(node.get(0))
  colorNodes(heldat)

$(document).on "mouseleave", "tr.node", ->
  resetTree()

# TODO: Too computationally inefficient. How do I improve this?
$(document).scroll ->
  resetTree()

makeModal = (node) ->
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

resetTree = ->
  if $('.node-modal').length > 0
    $('.node-modal').remove()
    $('.node-pointer').remove()
    colorNodesToPresent()

colorNodes = (heldat) ->
  circles = $('circle.node-dot, circle.node-dot-empty')
  circles.each ->
    if parseInt(this.parentNode.getAttribute("id")) > parseInt(heldat)
      this.setAttribute("class", "node-dot-empty")
    else
      this.setAttribute("class", "node-dot")

colorNodesToPresent = ->
  colorNodes(jQuery.now() * 0.001)