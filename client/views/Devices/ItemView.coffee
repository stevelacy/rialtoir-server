{modelView, DOM, Link} = require 'fission'
Model = require 'client/models/Device'

{div} = DOM

module.exports = modelView
  model: Model
  render: ->
    Link
      className: 'device-item-component'
      to: 'device'
      params:
        deviceId: @model._id
      @model.number
