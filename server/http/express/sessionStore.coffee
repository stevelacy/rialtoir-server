session = require 'express-session'
sessionstore = require('connect-redis')(session)
config = require '../../config'

module.exports = new sessionstore
  host: config.redis.host
  pass: config.redis.pass
  port: config.redis.port
  db: config.redis.dbIndex
