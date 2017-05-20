###*
 * Controls the swimlanes
###
App.define 'App.comonent.Swimlanes',
  refs:
    view: '#bot-swimlane-actions'

  init: () ->
    App.Util.makeDraggable @getView()
