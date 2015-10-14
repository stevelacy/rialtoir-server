{Schema} = require 'mongoose'

Model = new Schema
  device:
    type: Schema.Types.ObjectId
    required: true

  lat:
    type: String
    required: true
  lon:
    type: String
    required: true

module.exports = Model
