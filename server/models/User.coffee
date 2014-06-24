mongoose = require "mongoose"

randKey = ->
  text = ""
  possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  i = 0

  while i < 5
    text += possible.charAt Math.floor(Math.random() * possible.length)
    i++
  text



User = new mongoose.Schema
  username:
    type: String
    required: true
  id:
    type: Number
    required: true
  key:
    type: String
    default: randKey
  name:
    type: String
  token:
    type: String
  tokenSecret:
    type: String
  description:
    type: String
  location:
    type: String
  image:
    type: String
  provider:
    type: String

User.set "autoindex", false

module.exports = User
