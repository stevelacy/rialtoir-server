db = require '../../db'
passport = require 'passport'
app = require '../express'

app.use passport.initialize()
app.use passport.session()

app.get '/auth/logout', (req, res) ->
  req.logout()
  res.redirect '/'


fb = require './facebook'

module.exports = passport
