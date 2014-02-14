window.AssociationManager =

  initialize: ->
    @hideBlankAssociation()
    @bindDeleteEvent()
    @bindFlushEvent()
    @bindNewEvent()

  hideBlankAssociation: ->
    @blankAssociation().hide().collapse("hide")

  bindDeleteEvent: ->
    $(document).on "click", ".delete-association", (e) =>
      $association = $(e.currentTarget).closest('.association')
      $association.collapse("hide")
      $association.find('.destroy').prop('checked', true)
      false

  bindFlushEvent: ->
    $(document).on "click", ".flush-association", (e) =>
      $association = $(e.currentTarget).closest('.association')
      $association.on "hidden", (e) =>
        e.currentTarget.remove()
      $association.collapse("hide")
      false

  bindNewEvent: ->
    $(document).on "click", ".new-association", =>
      $blankAssociation = @blankAssociation()
      $newAssociation = @changeIndex($blankAssociation.clone(), @findAndIncrementIndex())
      $newAssociation.appendTo(".associations")
      $blankAssociation.show().collapse("show")
      false

  blankAssociation: ->
    $('.association').last()

  findAndIncrementIndex: () ->
    $newButton = $('.new-association').last()
    index = parseInt($newButton.attr("data-index"))
    $newButton.attr("data-index", index + 1)
    index

  changeIndex: ($association, index) ->
    associationHtml = $association.html().replace(/\[[0-9]+\]/g, "[#{index}]").replace(/_[0-9]+_/g, "_#{index}_")
    $association.html(associationHtml)

$ ->
  AssociationManager.initialize() if $('.association').length > 0