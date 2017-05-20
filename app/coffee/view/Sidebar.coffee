###*
 * Controls the main sidebar
###
App.define 'App.view.Sidebar',
  refs:
    view: '#sidebar-main'
    mask: '#mask'
    toggle:
      ref: '.app-sidebar-toggle'
      click: 'toggleSidebar'
    close:
      ref: '.app-sidebar-close'
      click: 'closeSidebar'

  ###*
   * Toggles the sidebar
  ###
  toggleSidebar: () ->
    @getView().toggleClass 'active'
    @getMask().toggleClass 'active'

  ###*
   * Closes the sidebar
  ###
  closeSidebar: () ->
    @getView().removeClass 'active'
    @getMask().removeClass 'active'
