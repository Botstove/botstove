App.define 'App.component.Modal',
  refs:
    view: '.modal'
    closeButton:
      ref: '> .modal-close'
      click: 'closeModal'

  ###*
   * Closes the modal
  ###
  closeModal: () ->
    @getView().removeClass 'active'
