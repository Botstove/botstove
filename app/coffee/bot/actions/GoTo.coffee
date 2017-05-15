Bot.define 'Bot.action.Goto',
  action:
    title: 'Go To'
    icon: 'arrow-right'

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

  run:
    console.log('hello world!')
