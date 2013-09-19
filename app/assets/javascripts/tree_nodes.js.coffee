$ ->
  window.TreeNodes =
    bindNodeHover: ->
      $('g.node').on "click", ->
        console.log "Wahoo"

  window.TreeNodes.bindNodeHover()