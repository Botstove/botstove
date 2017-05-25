###*
 * Defines a bot
###
App.define 'App.store.Bot',
  extend: 'App.store.Base'
  schema:
    bot:
      id: App.Guid.raw
      action: {}
