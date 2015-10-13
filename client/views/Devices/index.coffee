{collectionView, classes, DOM} = require 'fission'
io = require 'socket.io-client'
auth = require 'client/lib/auth'
ItemView = require './ItemView'
Model = require 'client/models/Device'
css = require './index.styl'

{div} = DOM

module.exports = collectionView
  displayName: 'Application'
  css: css
  itemView: ItemView
  collection:
    model: Model
  statics:
    willTransitionTo: auth

  render: ->
    div
      className: 'device-component'
      @items
