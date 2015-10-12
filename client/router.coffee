{router} = require 'fission'
App = require './views/App'

module.exports = router
  app:
    view: App
    path: '/'
