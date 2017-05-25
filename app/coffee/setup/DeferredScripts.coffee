###*
 * Simple class for deferring styles
###
App.define 'App.setup.DeferredScripts',
  refs:
    view: 'head'

  init: ->
    @getView()
      .append('<link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">')
      .append('<link href="//cdnjs.cloudflare.com/ajax/libs/dragula/3.7.2/dragula.min.css" rel="stylesheet">')
