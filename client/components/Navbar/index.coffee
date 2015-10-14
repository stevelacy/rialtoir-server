{component, DOM, Link} = require 'fission'
css = require './index.styl'

{div} = DOM

module.exports = component
  displayName: 'Navbar'
  css: css
  render: ->
    div
      className: 'navbar-component'
      Link
        to: '/'
        className: 'icon fa fa-crosshairs'
      div className: 'title', @props.title
