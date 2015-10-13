{view, classes, DOM, Link} = require 'fission'
css = require './index.styl'

{div, a} = DOM

module.exports = view
  displayName: 'Application'
  css: css

  render: ->
    div
      className: 'login-component'
      a
        className: 'button facebook'
        href: '/auth/facebook'
        'Login with Facebook'
