{view, classes, DOM, Link} = require 'fission'
css = require './index.styl'

{div, a} = DOM

module.exports = view
  displayName: 'Application'
  css: css

  render: ->
    div
      className: 'login-component'
      div className: 'header', 'Rialtoir'
      a
        className: 'button facebook'
        href: '/auth/facebook'
        'Login with Facebook'
