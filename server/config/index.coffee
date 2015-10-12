keys = require './keys'
{join} = require 'path'

module.exports =
  database: 'mongodb://localhost:27017/rialtoir'
  gcm:
    key: keys.gcm
  facebook: keys.facebook
  session:
    secret: 'koolcat'
    key: 'watlol'
  port: 9090
  pubdir: join __dirname, '../../public'
