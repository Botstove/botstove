###*
 * Configs class
###
App.define 'App.Config',
  ###*
   * Initial URI parameters
  ###
  params: URI(window.location).search true

  ###*
   * Determines if we have a param
   * @param  {STR}  param The parameter to look for
  ###
  hasParam: (key) ->
    _.has(@params, key)
