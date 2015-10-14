{modelView, classes, DOM, classes} = require 'fission'
io = require 'socket.io-client'
auth = require 'client/lib/auth'
Model = require 'client/models/Device'
Navbar = require 'client/components/Navbar'
parser = require 'phone-parser'
css = require './index.styl'

{div, i} = DOM

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
    gps: false
    panic: false

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
    @setState gps: true

  handlePanic: ->
    window.socket.emit 'panic', device: @model._id
    @setState panic: true

  render: ->
    div
      className: 'device-component'
      Navbar title: if @model? then parser @model.number, '(xxx) xxx-xxxx'

      div
        className: classes 'button gps', active: @state.gps
        onClick: @handleGps
        # 'GPS'
        i className: 'fa fa-map-marker'
      div
        className: classes 'button panic', active: @state.panic
        onClick: @handlePanic
        # 'PANIC'
        i className: 'fa fa-exclamation-triangle'

      div
        className: classes 'map', offline: not @state.map
        ref: 'map'
