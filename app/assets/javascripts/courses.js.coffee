# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# --------------------------------
# Sticky Tree
$(window).scroll ->
  headeroffset = 190
  treewrapperheight = 190
  scrolltop = $(this).scrollTop()
  topposition = $("#lesson-tree-anchor").offset().top
  bottomposition = $("#lesson-bottom-anchor").offset().top
  tree = $("#lesson-tree")

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
$(document).on "click", "a", ->
  $("html, body").animate
    scrollTop: $($.attr(this, "href")).offset().top
  , 1000
  false


# --------------------------------
# Node popups
$(document).on "mouseenter", "g.node", ->
  modalheight = 130
  modalwidth = 300
  treepadding = 40

  treetop = $("#lesson-tree").offset().top
  treeleft = $("#lesson-tree").offset().left
  nodex = parseInt(this.getAttribute("nodex"))
  nodey = parseInt(this.getAttribute("nodey"))

  $('main').append('<div class="node-modal"></div>')
  modal = $('.node-modal')
  modal.append("<blockquote><p class='lead'>#{this.getAttribute("nodename")}</p></blockquote")
  modal.append("<small>#{this.getAttribute("nodedesc")}</small>")
  modal.css
    height: modalheight
    width: modalwidth
    top: treetop + nodey - modalheight - 20
    left: Math.max.apply(null, [10, treeleft + nodex - modalwidth*0.5 + treepadding])

$(document).on "mouseleave", "g.node", ->
  $('.node-modal').remove()

$(document).scroll ->
  $('.node-modal').remove()
