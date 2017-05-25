App.define 'App.component.Modal',
  macros:
    closeModal: 'esc'

  refs:
    view: '.modal'
    closeButton:
      ref: '> .modal-close'
      click: 'closeModal'

  visible: []

  ###*
   * Closes the modal
  ###
  closeModal: ->
    @getView().removeClass 'active'
