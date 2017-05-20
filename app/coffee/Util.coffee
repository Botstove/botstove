###*
 * Handles draggables
###
App.define 'App.Util',
  ###*
   * Makes a component draggable
   * @param  {ELM|ARR} containers List of containers {ARR} or container {ELM}
   * @return {[type]}            [description]
  ###
  makeDraggable: (containers) ->
    if containers instanceof jQuery
      containers = containers.get()

    if typeof containers != 'object'
      containers = _.getValues containers

    dragula(containers)
