###*
 * Base Store
###
App.define 'App.store.Base',
  ###*
   * Contains the set of records
  ###
  records: []

  ###*
   * Creates a new record with defaults
   * @param  {OBJ} defaults List of defaults
   * @return {OBJ}          The created record
  ###
  new: (defaults) ->
    # Save to store controller
    record = @setDefaults @schema, defaults
    @records = records

    # Save to localStorage
    records = JSON.parse localStorage.getItem @storeId
    if !records then records = []
    records.push record
    localStorage.setItem @storeId, JSON.stringify(records)

    return record

  ###*
   * Go through and set default values
   * @param {OBJ} data     The dataset to [recursively] default through
   * @param {OBJ} data with defaults
  ###
  setDefaults: (data, defaults = {}) ->
    me = this
    values = {}

    _.each data, (val, key) ->
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

  ###*
   * Returns all the records
  ###
  getAll: ->
    @records

  ###*
   * Loads localstorage data into memory
  ###
  loadLocalStorage: ->
    records = JSON.parse localStorage.getItem @storeId
    if !records then records = {}
    @records = records
