Bot.define 'action.Goto',
  action:
    title: 'Go To'

  input: [
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
