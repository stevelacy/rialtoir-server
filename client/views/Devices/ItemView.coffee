{modelView, DOM, Link} = require 'fission'
parser = require 'phone-parser'
Model = require 'client/models/Device'

{div} = DOM

module.exports = modelView
  model: Model
  render: ->
    return null unless @model?
    Link
      className: 'device-item-component'
      to: 'device'
      params:
        deviceId: @model._id
      parser @model.number, '(xxx) xxx-xxxx'
