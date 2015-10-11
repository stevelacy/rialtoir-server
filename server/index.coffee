config = require './config'
http = require './http'

http.listen config.port
console.log 'starting on port:', config.port
