io = require 'socket.io-client'
router = require './router'
window.socket = io.connect()

router.start document.body
