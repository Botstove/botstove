###*
 * Controls the swimlanes
###
App.define 'App.component.Swimlanes',
  refs:
    view: '#bot-swimlane-actions'

  store:
    bot: 'App.store.Bot'

  init: () ->
    App.Util.makeDraggable @getView()
    console.log @getBotStore().new('bot')
