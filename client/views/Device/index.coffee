{modelView, classes, DOM} = require 'fission'
io = require 'socket.io-client'
auth = require 'client/lib/auth'
Model = require 'client/models/Device'
css = require './index.styl'

{div} = DOM

module.exports = modelView
  displayName: 'Application'
  css: css
  routeIdAttribute: 'deviceId'
  model: Model
  statics:
    willTransitionTo: auth
  mounted: ->
    socket = io.connect()
    socket.on 'connect', (e) ->
      console.log e
  render: ->
    return null unless @model?
    div
      className: 'device-component'
      @model.number
