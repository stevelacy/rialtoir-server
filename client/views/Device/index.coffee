{modelView, classes, DOM, classes} = require 'fission'
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
  init: ->
    map: false
    markers: []
    first: true

  mounted: ->
    return unless @isMounted()
    el = @refs.map.getDOMNode()

    myLatLng =
      lat: 38.8722344
      lng: -102.5484569

    map = new google.maps.Map el,
      center: myLatLng
      zoom: 4

    window.socket.on 'location', (device) =>
      return unless @isMounted()
      return unless device.device is @getParams().deviceId
      @setState map: true

      location = new google.maps.LatLng device.lat, device.lon

      marker = new google.maps.Marker
        map: map
        position: location
        title: device.number
      if @state.first
        map.setZoom 10
        map.setCenter location
        @setState first: false

  handleGps: ->
    window.socket.emit 'gps', device: @model._id

  handlePanic: ->
    window.socket.emit 'panic', device: @model._id

  render: ->
    div
      className: 'device-component'
      div className: 'header', @model?.number
      div
        className: 'button gps'
        onClick: @handleGps
        'GPS'
      div
        className: 'button panic'
        onClick: @handlePanic
        'PANIC'

      div
        className: classes 'map', offline: not @state.map
        ref: 'map'
