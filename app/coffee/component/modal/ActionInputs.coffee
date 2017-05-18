###*
 * Controls the Action Inputs modal
###
App.define 'App.component.modal.ActionInputs',
  refs:
    view: '#modal-bot-inputs'
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
    console.log('Saving')
