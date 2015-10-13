me = require 'client/me'

module.exports = (t) ->
    return t.redirect '/' unless me?
