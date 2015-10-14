{join} = require 'path'
{argv} = require 'optimist'
merge = require 'lodash.merge'
env = argv.env or process.env.NODE_ENV or 'local'

configWithEnv = require "./#{env}"
configDefault = require './default'

conf = merge configDefault, configWithEnv
module.exports = conf
