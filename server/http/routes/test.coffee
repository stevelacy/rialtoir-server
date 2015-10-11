{send} = require '../../lib/gcm'

module.exports = (req, res, next) ->
  # opts =
  #   message:
  #     title: 'Rialtior Alert'
  #     icon: 'ic_launcher'
  #     body: 'Alert called'
  #   data:
  #     action: 'panic'
  #     message: 'message here'
  #     device: '992992992929'

  opts =
    data:
      action: 'gps'

  device = id: 'APA91bGjJCTJeuBvoD0dibbq9BIQvmZ_gghQakcLphsnyEkTIRIEV34w8NgrEYpTf2EsdharmnwOvEipgxMxNqMqqq4JDkIhfh6RJ3RS05Q-d_xKc0Tnd9NMkExVOs6bFoeJiup-umGF'

  send opts, device, (err, data) ->
    console.log err, data
    res.end()
