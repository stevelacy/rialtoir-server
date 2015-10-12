{view, classes, DOM} = require 'fission'

{div} = DOM
css = require './index.styl'

module.exports = view
  displayName: 'Application'
  css: css
  render: ->
    div
      className: 'application-component'
      'the app'
