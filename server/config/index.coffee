keys = require './keys'

module.exports =
  database: 'mongodb://localhost:27017/rialtoir'
  gcm:
    key: keys.gcm
  session:
    secret: 'koolcat'
    key: 'watlol'
  port: 9091
