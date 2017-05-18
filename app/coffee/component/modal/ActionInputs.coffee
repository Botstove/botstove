###*
 * Controls the Action Inputs modal
###
App.define 'App.component.modal.ActionInputs',
  refs:
    view: '#modal-bot-inputs'
    form: '> .modal-body .content'
    checkboxes:
      ref: '> [type=checkbox]'
      change: 'setCheckboxValue'
    remove:
      ref: '.repeater-deleter'
      click: 'removeGroup'
    repeater:
      ref: '.repeater'
      click: 'repeatGroup'
    submit:
      ref: '> .modal-footer .btn-primary'
      click: 'save'

  ###*
   * Stores a list of name: [values...] for the form
  ###
  values: {}

  ###*
   * Repeats the group of inputs
  ###
  repeatGroup: (button) ->
    $fieldset = $(button).closest('fieldset')
    $fieldset.clone().insertAfter($fieldset)

  ###*
   * Removes the repeater group
  ###
  removeGroup: (button) ->
    $(button).closest('fieldset').remove()

  ###*
   * Saves the action and adds it to the actions array in local/remote
  ###
  save: () ->
    @getSubmit().addClass 'loading'
    console.log @getValues()
    @getSubmit().removeClass 'loading'

  ###*
   * Gets the values using the .inputs
  ###
  getValues: () ->
    me = this
    values = @getForm().data('values')

    _.each values, (value, key) ->
      values[key] = []
      me.getForm().find("[name=#{key}]").each (el) ->
        values[key].push $(this).val()

    values

  ###*
   * Sets the checkbox value when clicked
  ###
  setCheckboxValue: (checkbox) ->
    $checkbox = $(checkbox)
    value = if $checkbox.is ':checked' then $checkbox.data 'on-value' else $checkbox.data 'off-value'
    $(checkbox).val value
