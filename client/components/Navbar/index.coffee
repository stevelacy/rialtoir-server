{component, DOM} = require 'fission'

{div} = DOM

module.exports = component
  displayName: 'Navbar'
  render: ->
    div null, 'Rialtoir'
