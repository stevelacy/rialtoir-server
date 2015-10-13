{view, classes, DOM, ChildView} = require 'fission'
css = require './index.styl'
Navbar = require 'client/components/Navbar'

{div} = DOM

module.exports = view
  displayName: 'Application'
  css: css
  render: ->
    div
      className: 'application-component'
      Navbar()
      ChildView()
