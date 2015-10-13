{view, classes, DOM, ChildView} = require 'fission'
io = require 'socket.io-client'
css = require './index.styl'
Navbar = require 'client/components/Navbar'

{div} = DOM

module.exports = view
  displayName: 'Application'
  css: css
  mounted: ->
    socket = io.connect()
    socket.on 'connect', (e) ->
      console.log e
  render: ->
    div
      className: 'application-component'
      Navbar()
      ChildView()
