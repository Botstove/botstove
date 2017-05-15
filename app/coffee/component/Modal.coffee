App.define 'App.component.Modal',
  refs:
    view: '.modal'
    closeButton:
      ref: '> button.btn-clear'
      click: 'closeModal'
    mask:
      ref: '> .modal-overlay'
      click: 'closeModal'

  ###*
   * Closes the modal
  ###
  closeModal: () ->
    @getView().removeClass 'active'
