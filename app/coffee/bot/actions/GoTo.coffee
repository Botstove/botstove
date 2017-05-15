Bot.define 'Bot.action.Goto',
  action:
    title: 'Go To'
    icon: 'arrow-right'

  inputs: [
    {
      type: 'group'
      fields: [
        {
          type: 'text'
          label: 'URL'
        }
        {
          type: 'checkbox'
          label: 'New Tab?'
        }
        {
          type: 'repeater'
        }
      ]
    }
  ]
