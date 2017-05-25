###*
 * Controls the swimlanes
###
App.define 'App.component.Swimlanes',
  listen: ['botStoreReady']

  refs:
    view: '#bot-swimlane-actions'

  store:
    bot: 'App.store.Bots'

  ###*
   * The current bot
  ###
  currentBot: null

  init: ->
    App.Util.makeDraggable @getView()

  botStoreReady: ->
    @currentBot = @getBotStore().getMostRecentBot()
    console.log @currentBot
