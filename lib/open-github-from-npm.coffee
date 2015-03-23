{CompositeDisposable} = require 'atom'
Shell = require 'shell'
githubUrlFromNpm = require 'github-url-from-npm'
OpenGithubFromNpmView = require './open-github-from-npm-view'

module.exports =
  cache: {}

  activate: ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace',
      'open-github-from-npm:open': => @open()

  deactivate: ->
    @subscriptions?.dispose()
    @cache = null

  open: ->
    editor = atom.workspace.getActiveTextEditor()
    text = editor.getSelection().getText()
    return unless text

    if @cache[text]
      Shell.openExternal @cache[text]
      return

    dialog = new OpenGithubFromNpmView
    dialog.attach()
    githubUrlFromNpm text, (err, url) =>
      return dialog.showError(err) if err

      @cache[text] = url
      Shell.openExternal url
      dialog.close()
