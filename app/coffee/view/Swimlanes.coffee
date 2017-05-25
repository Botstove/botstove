###*
 * Controls the swimlanes
###
App.define 'App.component.Swimlanes',
  listen: [
    'botStoreReady'
    'saveBot'
  ]

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

  ###*
   * Loads the bot
  ###
  botStoreReady: ->
    @currentBot = @getBotStore().getMostRecentBot()
    console.log @currentBot

  ###*
   * Saves each swimlane
  ###
  saveBot: ->
