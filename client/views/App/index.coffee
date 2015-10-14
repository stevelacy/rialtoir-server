{view, classes, DOM, ChildView} = require 'fission'
css = require './index.styl'

{div} = DOM

module.exports = view
  displayName: 'Application'
  css: css
  render: ->
    div
      className: 'application-component'
      ChildView()
