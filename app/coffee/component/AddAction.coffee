###*
 * Controls the "Add Action" panel
###
App.define 'App.component.AddAction',
  macros:
    'a': 'showSelector'

  refs:
    view: '#bot-actions'
    button:
      ref: '> .btn-bot-action'
      click: 'addAction'
    form: '#modal-bot-inputs .modal-body .content'
    modal: '#modal-bot-inputs'
    popoverButton: '#popover-add-action > button'

  ###*
   * Adds an action to the users bot
   * @param {ELM} button The calling button
  ###
  addAction: (button) ->
    controller = _.get window, $(button).data('action')

    $ _.template(App.Decode.slim($('#template-swimlane-action').html()))(controller.action)
    .appendTo('#bot-swimlane-actions')
    .find '.bot-swimlane-input'
    .click _.bind(@generateModal, this, controller)

  ###*
   * Generates the modal based on whats in controller.action
   * @param  {STR} controller The calling controller
  ###
  generateModal: (controller) ->
    @getModal().addClass 'active'
    @getForm().html ''
    @generateInput controller.inputs, @getForm()

  ###*
   * Loops through and generates each input element
   * @param  {OBJ} inputs The list of inputs to generate
   * @param  {ELM} parent The group to nest the elements inside of
   * @return {STR} The combined HTML
  ###
  generateInput: (inputs, group) ->
    me = this

    _.each inputs, (input) ->
      if input.type == 'group'
        $fieldset = $('<fieldset />')
        me.generateInput input.fields, $fieldset.appendTo(group)
        $fieldset.wrap('<div class="repeater-group" />')

      parent = $('<div class="form-group" />').appendTo group
      guid = App.Guid.raw()

      if input.label and input.type != 'checkbox'
        $('<label/>',
          for: guid
          class: 'form-label'
        ).text(input.label).appendTo parent

      switch input.type
        when 'text'
          $('<input />',
            type: input.type
            id: guid
            class: 'form-input'
          ).appendTo parent

        when 'checkbox'
          $('<label id="' + guid + '" class="form-switch"><input type="checkbox" id="' + guid + '"><i class="form-icon"></i> ' + input.label + '</label>').appendTo(parent)

        when 'repeater'
          label = input.label or 'Add another'
          $('<button class="btn btn-primary btn-sm float-right repeater">' + label + '</button>')
          .appendTo group

          $('<button class="btn btn btn-sm btn-error float-right repeater-deleter push-right">Remove</button>')
          .appendTo group

  showSelector: () ->
    @getPopoverButton().focus()
