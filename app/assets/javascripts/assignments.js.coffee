window.QuestionManager =
  initialize: ->
    @hideBlankQuestion()
    @bindDeleteEvent()
    @bindFlushEvent()
    @bindNewEvent()

  hideBlankQuestion: ->
    @blankQuestion().hide()

  bindDeleteEvent: ->
    $(document).on "click", ".delete-question", (e) =>
      $question = $(e.currentTarget).closest('.question')
      $question.collapse("hide")
      $question.find('.destroy').prop('checked', true)
      false

  bindFlushEvent: ->
    $(document).on "click", ".flush-question", (e) =>
      $question = $(e.currentTarget).closest('.question')
      $question.remove()
      false

  bindNewEvent: ->
    $(document).on "click", ".new-question", =>
      $blankQuestion = @blankQuestion()
      $newQuestion = @changeIndex($blankQuestion.clone(), @findAndIncrementIndex())
      $newQuestion.appendTo(".questions")
      $blankQuestion.show()
      false

  blankQuestion: ->
    $('.question').last()

  findAndIncrementIndex: () ->
    $newButton = $('.new-question').last()
    index = parseInt($newButton.attr("data-index"))
    $newButton.attr("data-index", index + 1)
    index

  changeIndex: ($question, index) ->
    questionHtml = $question.html().replace(/\[[0-9]+\]/g, "[#{index}]").replace(/_[0-9]+_/g, "_#{index}_")
    $question.html(questionHtml)

$ ->
  QuestionManager.initialize() if $('.question').length > 0