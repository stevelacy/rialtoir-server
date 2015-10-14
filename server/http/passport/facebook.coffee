passport = require 'passport'
ppfb = require 'passport-facebook'
config = require '../../config'
app = require '../express'
{User} = require '../../db'

FacebookStrategy = ppfb.Strategy

importedParams = [
  'fbid'
  'name'
]

# fb profile parsers
getLookingFor = (profile) ->
  return unless profile.interested_in?
  return 'either' if profile.interested_in.length is 2
  return profile.interested_in[0]

getCareer = (profile) ->
  return profile.work?[0]?.position?.name

getLocation = (profile) ->
  return profile.location?.name

# cherry pick fields of facebook json to make a user profile
profileToUser = (profile, accessToken, user) ->
  profile.fbid = profile.id

  # dive into the shitty object and yank out some data
  profile.lookingFor = getLookingFor profile
  profile.location = getLocation profile
  profile.career = getCareer profile

  # dont let fb overwrite our sacred vars
  delete profile[k] for k, v of profile when !~importedParams.indexOf k

  profile.token = accessToken
  return profile

# main login handler
handleLogin = (accessToken, refreshToken, profile, done) ->
  theoreticalUser = profileToUser profile._json, accessToken

  q = User.findOne fbid: theoreticalUser.fbid
  q.exec (err, user) ->
    return done err if err?
    if user?
      profile._json.id = user.fbid
      existingUser = profileToUser profile._json, accessToken, user
      handleExistingLogin user, existingUser, done
    else
      handleFirstLogin theoreticalUser, profile, done

# login handler for users who have logged in before
handleExistingLogin = (user, profile, cb) ->
  user.set profile
  user.save cb

# login handler for users who have never logged in
handleFirstLogin = (theoreticalUser, profile, cb) ->
  User.create theoreticalUser, (err, user) ->
    console.error err if err?
    if err?.code is 11000
      return cb 'email already in use'
    # TODO: handle all passport errors
    return cb '500 server error' if err?
    cb null, user

# serializing used for signed cookies
userToString = (user, cb) ->
  cb null, String user._id

stringToUser = (_id, cb) ->
  User.findById _id, cb

# internals to facebook login
strategyConfig =
  clientID: config.facebook.id
  clientSecret: config.facebook.key
  callbackURL: config.facebook.callback
  display: 'touch'
  scope: [
    'public_profile'
  ]

strategy = new FacebookStrategy strategyConfig, handleLogin

passport.use strategy
passport.serializeUser userToString
passport.deserializeUser stringToUser

app.get '/auth/facebook/callback', passport.authenticate 'facebook',
  display: 'touch'
  failureRedirect: '/login'
  successRedirect: '/'

app.get '/auth/facebook', passport.authenticate 'facebook',
  display: 'touch'


module.exports = passport
