Bot =
  ###*
   * Defines a new class
   * @param  {STR} className The classname
   * @param  {OBJ} config    The config object
  ###
  define: (className, config) ->
    _.set window, className, config

    @setup.refs className
    @createUI className
    controller = _.get window, className

    setTimeout ->
      controller.init and controller.init()
      return

    return

  setup:
    ###*
     * Sets up controller refs
     * - If the ref begins with > then it is a decendent of a ref labeled "view" (which must exist)
     * - Refs are cached
     * - If an object is passed, then a key labeled "ref" must exist which reps the selector
     *   - All other keys represent event selectors
     * @param  {STR} className The class name
    ###
    refs: (className) ->
      controller = _.get window, className
      controller.className = className
      view = if controller.refs then controller.refs.view else ''
      view = if _.isString(view) then {ref: view} else view

      _.each controller.refs, (val, key) ->
        val = if _.isString(val) then {ref: val} else val
        if _.first(val.ref) == '>'
          val.ref = view.ref + ' ' + _.trimStart(val.ref, '>')

        # Setup getter
        getter = 'get' + _.upperFirst(key)
        controller[getter] = ->
          $ val.ref

        # Bind events
        _.each val, (callback, event) ->
          if event != 'ref'
            $(document).on event, val.ref, ->
              args = _.toArray(arguments)
              args.unshift this
              controller[callback].apply controller, args
          return
        return

  ###*
   * Creates the draggable UI
   * @param {STR} className The calling classname
  ###
  createUI: (className) ->
    controller = _.get window, className

    if controller.action
      template = _.template(App.Decode.slim($('#template-bot-action').html())) controller.action

      $ template
      .appendTo '#bot-actions'
      .data 'action', className

    return

  ###*
   * Various decoder methods
  ###
  Decode:
    slim: (str) ->
      str.replace(/&gt;/g, '>').replace(/&lt;/g, '<')
