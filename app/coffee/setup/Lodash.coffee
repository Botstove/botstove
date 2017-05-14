_.mixin
  bindKeyRight: (context, key) ->
    args = _.toArray(arguments).slice(2)
    args.unshift _.bindKey(context, key)
    _.partialRight.apply _, args
  bindRight: (fn, context) ->
    args = _.toArray(arguments).slice(2)
    args.unshift _.bind(fn, context)
    _.partialRight.apply _, args
