###*
 * Base Store
###
App.define 'App.store.Base',
  ###*
   * Contains the set of records
  ###
  records: {}

  ###*
   * Creates a new record
   * @param  {OBJ} defaults List of [deep] defaults
   * @return {OBJ}          The newly created record
  ###
  new: (defaults) ->
    defaults = if defaults then defaults else {}

    id = App.Guid.raw()
    @records[id] = _.defaults defaults,
      id: id
