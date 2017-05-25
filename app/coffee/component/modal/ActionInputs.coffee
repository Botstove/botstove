###*
 * Controls the Action Inputs modal
###
App.define 'App.component.modal.ActionInputs',
  refs:
    view: '#modal-bot-inputs'
    activeLane: '#bot-swimlane-actions .active.bot-swimlane-input'
    checkboxes:
      ref: '> [type=checkbox]'
      change: 'setCheckboxValue'
    form: '> .modal-body .content'
    remove:
      ref: '> .repeater-deleter'
      click: 'removeGroup'
    repeater:
      ref: '> .repeater'
      click: 'repeatGroup'
    submit:
      ref: '> .modal-footer .btn-primary'
      click: 'save'

  ###*
   * Repeats the group of inputs
  ###
  repeatGroup: (button) ->
    $fieldset = $(button).closest 'fieldset'
    $fieldset.clone().insertAfter $fieldset

  ###*
   * Removes the repeater group
  ###
  removeGroup: (button) ->
    $(button).closest('fieldset').remove()

  ###*
   * Saves the data to the DOM
  ###
  save: ->
    $pre = @getActiveLane().children('pre')
    values = @getValues()
    jsonString = JSON.stringify(values, null, 2)
    App.table 'Saving action inputs...', values

    if $pre.length
      $pre.text jsonString
    else
      @getActiveLane().prepend "<pre class='bot-swimlane-input-values'>#{jsonString}</pre>"

    @getSubmit().removeClass 'loading'
    @getView().removeClass 'active'
    @getActiveLane().data 'inputs', values
    App.trigger 'saveBot'

  ###*
   * Gets the values using the .inputs
   * @return {ARR} The values
  ###
  getValues: ->
    me = this
    values = @getForm().data 'values'

    _.each values, (value, key) ->
      values[key] = []
      me.getForm().find("[name=#{key}]").each (el) ->
        $field = $(this)
        switch $field.attr 'type'
          when 'text'
            values[key].push $field.val()
          when 'checkbox'
            values[key].push(if $field.prop 'checked' then $field.data 'on-value' else $field.data 'off-value')

    return values

  ###*
   * Sets the checkbox value when clicked
  ###
  setCheckboxValue: (checkbox) ->
    $checkbox = $(checkbox)
    value = if $checkbox.is ':checked' then $checkbox.data 'on-value' else $checkbox.data 'off-value'
    $(checkbox).val value
