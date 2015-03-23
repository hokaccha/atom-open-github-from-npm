{View} = require 'atom-space-pen-views'

module.exports =
class OpenGithubFromNpmView extends View
  @content: () ->
    @div class: 'open-github-from-npm-view', =>
      @div class: 'open-github-from-npm-spinner', outlet: 'loading'
      @div class: 'error-message', outlet: 'errorMessage'

  initialize: () ->

  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element)

  close: ->
    panelToDestroy = @panel
    @panel = null
    panelToDestroy?.destroy()

  showError: (message) ->
    @loading.hide()
    @errorMessage.text(message)
    setTimeout (=> @close()), 2000
