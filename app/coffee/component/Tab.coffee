###*
 * Controls Spectre Tabs
###
App.define 'App.component.Tab',
  refs:
    tabs:
      ref: '[data-tab-target]'
      click: 'onTabClick'

  onTabClick: (tab) ->
    tab = $ tab
    tabs = tab.closest '[data-tab-target-group]'
    target = tab.data 'tab-target'
    group = tabs.data 'tab-target-group'

    # Activate tab label
    tabs.children().removeClass 'active'
    tab.addClass 'active'

    # Activate panel
    panels = $ '[data-tab-group=' + group + ']'
    panels.find('[data-tab-panel]').removeClass 'active'
    $('[data-tab-panel=' + target + ']').addClass 'active'
