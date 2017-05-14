###*
 * Simple class for deferring styles
###
App.define 'App.setup.Styles',
  refs:
    view: 'head'

  init: () ->
    @getView().append('<link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">')
    return
