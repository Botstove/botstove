Bot.define 'Bot.action.Goto',
  action:
    title: 'Go To'
    description: 'Go to URL, then...'
    icon: 'arrow-right'

  inputs: [
    {
      name: 'name'
      type: 'text'
    }
    {
      type: 'group'
      fields: [
        {
          name: 'url'
          type: 'text'
          label: 'URL'
        }
        {
          name: 'newTab'
          type: 'checkbox'
          label: 'New Tab?'
        }
        {
          type: 'repeater'
        }
      ]
    }
  ]
