{join} = require 'path'
module.exports =
  database: 'mongodb://localhost:27017/rialtoir'
  session:
    secret: 'koolcat'
    key: 'watlol'
  port: 9090
  pubdir: join __dirname, '../../public'
  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 12
    port: 6379
