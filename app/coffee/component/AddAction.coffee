###*
 * Controls the "Add Action" panel
###
App.define 'App.component.AddAction',
  refs:
    view: '#bot-actions'
    button:
      ref: '> .btn-bot-action'
      click: 'addAction'
    modal: '#modal-bot-inputs'

  ###*
   * Adds an action to the users bot
   * @param {ELM} button The calling button
  ###
  addAction: (button) ->
    controller = _.get window, $(button).data('action')

    $ _.template(App.Decode.slim($('#template-swimlane-action').html()))(controller.action)
    .appendTo('#bot-swimlane-actions')
    .find '.bot-swimlane-input'
    .click _.bind(@generateModalInputs, this, controller)

  ###*
   * Generates the modal based on whats in controller.action
   * @param  {STR} controller The calling controller
  ###
  generateModalInputs: (controller) ->
    @getModal().addClass 'active'

    _.each controller.inputs, (input) ->
      return

    return
