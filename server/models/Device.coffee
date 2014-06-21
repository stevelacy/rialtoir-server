mongoose = require "mongoose"
Schema = mongoose.Schema

Device = new Schema
  gcmId:
    type: String
    required: true
  number:
    type: String
    required: true
  key:
    type: String


Device.set "autoindex", false

module.exports = Device
