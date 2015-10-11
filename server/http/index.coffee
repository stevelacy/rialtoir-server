app = require '../express'
req = require 'require-dir'

routes = req './routes'

app.get '/test', routes.test
app.post '/register', routes.register
app.post '/gps', routes.gps

module.exports = app
