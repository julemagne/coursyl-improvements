window.ScrollManager =

  bindSmoothNav: ->
    $(document).on "click", ".smooth-nav a", (e) =>
      $("html").animate
        scrollTop: $($.attr(e.currentTarget, "href")).offset().top
      , 700
      false

  bindStickyTree: ->
    $(window).scroll =>
      tree = $("#lesson-tree")
      if tree.length > 0
        headerOffset = 190
        treeWrapperHeight = 190
        scrollTop = $('html').scrollTop()
        topPosition = $("#lesson-tree-anchor").offset().top
        bottomPosition = $("#lesson-bottom-anchor").offset().top

        if (scrollTop > topPosition - headerOffset) and (scrollTop < bottomPosition - (headerOffset+treeWrapperHeight))
          tree.css
            position: "fixed"
            top: "#{headerOffset}px"

        else
          if tree.css('position') is "fixed"
            if (scrollTop <= topPosition - headerOffset)
              tree.css
                position: "relative"
                top: ""
            else
              tree.css
                position: "relative"
                top: "#{bottomPosition-topPosition-treeWrapperHeight}px"

$ ->
  ScrollManager.bindSmoothNav() if $('.smooth-nav a').length > 0
  ScrollManager.bindStickyTree() if $('#lesson-tree').length > 0
  $('body').css("padding-top", "200px") if $('.course-summary-fixed').length > 0
