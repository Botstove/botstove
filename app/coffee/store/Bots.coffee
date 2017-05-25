###*
 * Defines a bot
###
App.define 'App.store.Bots',
  extend: 'App.store.Base'
  storeId: 'Bots'
  schema:
    id: App.Guid.raw
    actions: []

  init: ->
    @loadLocalStorage()
    setTimeout ->
      App.trigger 'botStoreReady'

  ###*
   * Gets the most recent record (or creates a new one)
  ###
  getMostRecentBot: ->
    return if _.isEmpty @getAll() then @new() else _.last(@records)
