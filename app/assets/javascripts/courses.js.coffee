window.ScrollManager =

  bindSmoothNav: ->
    $(document).on "click", ".smooth-nav a", (e) =>
      $("html, body").animate
        scrollTop: $($.attr(e.currentTarget, "href")).offset().top
      , 700
      false

  bindStickyTree: ->
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

$ ->
  ScrollManager.bindSmoothNav() if $('.smooth-nav a').length > 0
  ScrollManager.bindStickyTree() if $('#lesson-tree').length > 0
