gulp = require 'gulp'
webpack = require 'webpack'
nodemon = require 'gulp-nodemon'
reload = require 'gulp-livereload'
webpackConfig = require './webpack.config'

paths =
  public: __dirname + '/public'

tasks =
  html:
    src: ['./client/index.html']
    dest: paths.public
    watch: true
  img:
    src: ['./client/img/**']
    dest: paths.public
    watch: true

packer = webpack webpackConfig

gulp.task 'bundle', (cb) ->
  packer.watch aggregateTimeout: 300, (err, stats) ->
    console.error err if err?
    console.log 'bundle finished'
    reload.reload()
    cb()

gulp.task 'server', (cb) ->
  watcher = nodemon
    script: './server'
    watch: ['./server']
    ext: 'js json coffee'

  watcher.once 'start', cb
  watcher.on 'start', ->
    # TODO: make sure this is actually right
    setTimeout reload.reload, 1000
  return

names = ['bundle', 'server']

for task of tasks
  do (task) ->
    names.push task
    gulp.task task, ->
      gulp
        .src tasks[task].src
        .pipe gulp.dest tasks[task].dest
        .pipe reload()
    if tasks[task].watch
      gulp.watch tasks[task].src, gulp.parallel task

reload.listen()
gulp.task 'default', gulp.parallel names
