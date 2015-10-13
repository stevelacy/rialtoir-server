express = require 'express'
session = require 'express-session'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
methodOverride = require 'method-override'
config = require '../../config'
sessionStore = require './sessionStore'

app = express()
app.disable 'x-powered-by'

app.use methodOverride()
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: false
app.use cookieParser config.session.secret

app.use session
  store: sessionStore
  key: config.session.key
  secret: config.session.secret
  resave: false
  saveUninitialized: false
  cookie:
    maxAge: 31536000000

module.exports = app
