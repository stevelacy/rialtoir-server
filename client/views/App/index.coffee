{view, classes, DOM} = require 'fission'

{div} = DOM

module.exports = view
  displayName: 'Application'
  render: ->
    div
      className: 'application-component'
      'the app'
