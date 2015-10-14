me = require 'client/me'

module.exports = (t) ->
    return t.redirect '/login' unless me?
