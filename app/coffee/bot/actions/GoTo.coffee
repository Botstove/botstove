Bot.define 'Bot.action.Goto',
  action:
    title: 'Go To'
    icon: 'arrow-right'

  inputs: [
    {
      type: 'group'
      repeater: true
      fields: [
        {
          type: 'text'
          label: 'URL'
        }
        {
          type: 'check'
          label: 'New Tab?'
        }
      ]
    }
  ]
