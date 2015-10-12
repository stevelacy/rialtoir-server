req = require 'require-dir'
app = require './express'

routes = req './routes'

app.get '/test', routes.test
app.post '/register', routes.register
app.post '/gps', routes.gps

passport = require './passport'
spa = require './express/spa'

module.exports = app
