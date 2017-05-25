###*
 * Base Store
###
App.define 'App.store.Base',
  ###*
   * Contains the set of records
  ###
  record: {}

  ###*
   * Creates a new record at the specified root
  ###
  new: (field, defaults) ->
    if field
      root = _.get @schema, field
    else
      root = @schema

    @setDefaults root, defaults

  ###*
   * Go through and set default values
  ###
  setDefaults: (root, defaults = {}) ->
    me = this
    values = {}

    _.each root, (val, key) ->
      if !_.has defaults, key
        defaults[key] = val

      if _.isFunction val
        val = val()
      else if _.isObject val
        val = me.setDefaults val, defaults[key]

      if !_.isEmpty(defaults[key])
        val = defaults[key]

      values[key] = val

    return values
