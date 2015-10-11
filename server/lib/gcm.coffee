{Message, Sender} = require 'node-gcm'
config = require '../config'

module.exports =
  send: (opts, device, cb) ->
    message = new Message opts
    sender = new Sender config.gcm.key

    ids = [device.id]

    sender.send message, registrationIds: ids, cb
