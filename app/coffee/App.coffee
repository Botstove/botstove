App =
  # List of events to listen to
  # - Each property is an array of classes to call this method on
  listen: {}

  ###*
   * Defines a new class
   * @param  {STR} className The classname
   * @param  {OBJ} config    The config object
  ###
  define: (className, config) ->
    _.set window, className, config

    @setup.listeners className
    @setup.refs className
    @setup.templates className
    @setup.macros className
    controller = _.get window, className

    setTimeout ->
      controller and App.setup.extends(className, config)
      App.setup.stores className
      controller.init and controller.init()

  setup:
    ###*
     * Applies the listen config
     * @param  {STR} className The class name to apply to
    ###
    listeners: (className) ->
      controller = _.get window, className
      if controller.listen
        _.each controller.listen, (event) ->
          _.set App.listen, event + '.' + App.Encode.className(className), true

    ###*
     * Applies methods for extending
     * @param  {STR} className The class name
     * @param  {OBJ} config    The config object
    ###
    extends: (className, config) ->
      config = _.defaults(_.get(window, className), _.get(window, config.extend))

    ###*
     * Sets up controller refs
     * - If the ref begins with > then it is a decendent of a ref labeled "view" (which must exist)
     * - Refs are cached
     * - If an object is passed, then a key labeled "ref" must exist which reps the selector
     *   - All other keys represent event selectors. The value represtents App.trigger(value)
     * @param  {STR} className The class name
    ###
    refs: (className) ->
      controller = _.get window, className
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

    ###*
     * Sets up the templates
     * - Creates a .get{Name}Template() getter
    ###
    templates: (className) ->
      controller = _.get window, className

      _.each controller.templates, (template, key) ->
        getter = 'get' + _.upperFirst(key) + 'Template'

        controller[getter] = (data) ->
          _.template(App.Decode.slim($(template).html())) data

    ###*
     * Sets up stores
     * @param  {STR} className The classname to check
    ###
    stores: (className) ->
      controller = _.get window, className
      store = controller.store

      _.each store, (getter, ref) ->
        controller['get' + _.capitalize(ref) + 'Store'] = () ->
          _.get window, getter

    ###*
     * Keyboard Macros
     * @param  {STR} className The classname to check
    ###
    macros: (className) ->
      controller = _.get window, className
      macros = controller.macros

      _.each macros, (macro, action) ->
        Mousetrap.bind macro, _.bind(controller[action], controller)

  ###*
   * Triggers an event, passing along any data
   * @param  {STR} event The event name to trigger
   * @param  {ANY} [...] Additional data to pass to the event
   * @return {ANY} The value returned by the triggered method
  ###
  trigger: (event) ->
    result = null

    args = Array::slice.call(arguments, 1)
    _.each App.listen[event], (val, className) ->
      controller = _.get(window, App.Decode.className(className))
      result = controller[event].apply controller, args

    result

  ###*
   * @FIXME These need to be moved into classes
  ###
  Encode:
    className: (str) ->
      str.replace /\./g, '|'

  Decode:
    className: (str) ->
      str.replace /\|/g, '.'
    slim: (str) ->
      str.replace(/&gt;/g, '>').replace(/&lt;/g, '<')

  Guid:
    ###*
     * Returns a GUID
    ###
    raw: () ->
      Guid.raw()

  ###*
   * Console logger, used when ?debug flag is used
  ###
  log: () ->
    if App.Config.hasParam 'debug' then console.log arguments
  table: (message) ->
    if App.Config.hasParam 'debug'
      console.info message
      console.table arguments
