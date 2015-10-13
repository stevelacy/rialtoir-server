{join} = require 'path'
staticFiles = require 'serve-static'
app = require './'
config = require '../../config'
createAuth = require './createAuth'
idxFile = join config.pubdir, 'index.html'

# if config.env is 'local' or config.env is 'test' or config.mode is 'static'
app.use staticFiles config.pubdir

# app.get '/config.js', (req, res, next) ->
#   return next() unless req.isAuthenticated()
#   cfg =
#     endpoint: "#{config.docker.url}:#{config.docker.port}"
#   res.set 'Content-Type', 'application/javascript'
#   res.status 200
  # res.send "window._config = #{JSON.stringify cfg};"

app.get '/auth.js', (req, res, next) ->
  createAuth req.user, (src) ->
    res.set 'Content-Type', 'application/javascript'
    res.status 200
    res.send src

app.get '/*', (req, res) ->
  res.sendFile idxFile

module.exports = app
