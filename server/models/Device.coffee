{Schema} = require 'mongoose'

Model = new Schema
  id:
    type: String
    required: true

  number:
    type: String
    required: true

module.exports = Model
