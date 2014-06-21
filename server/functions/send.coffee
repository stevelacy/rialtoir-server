gcm = require "node-gcm"
config = require "../../config"
db = require "../db"

Device = db.models.Device


module.exports = (id, msg, cb) ->
  Device.findOne {_id: id}, (err, data) ->
    return cb err if err?
    return console.log "device not found" unless data?

    message = new gcm.Message()
    message.addDataWithKeyValue "message", msg

    sender = new gcm.Sender config.keys.gcm.key
    registrationIds = []
    registrationIds.push data.gcmId

    sender.send message, registrationIds, config.gcm.retries, (err, result) ->
      cb err, result
