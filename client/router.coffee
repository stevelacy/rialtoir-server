{router} = require 'fission'
App = require './views/App'
Login = require './views/Login'
Device = require './views/Device'
Devices = require './views/Devices'

module.exports = router
  app:
    view: App
    path: '/'
    children:
      login:
        view: Login
        path: 'login'
      devices:
        view: Devices
        path: 'devices'
      device:
        view: Device
        path: 'devices/:deviceId'
