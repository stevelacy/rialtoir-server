{Schema} = require 'mongoose'

Model = new Schema
  fbid:
    type: String
    required: true

  authorized:
    type: Boolean
    default: false

  name:
    type: String

module.exports = Model
