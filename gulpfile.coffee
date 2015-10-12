gulp = require 'gulp'
webpack = require 'webpack'
nodemon = require 'gulp-nodemon'
browserSync = require 'browser-sync'
webpackConfig = require './webpack.config'
config = require './server/config'

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


gulp.task 'bundle', (cb) ->
  webpack webpackConfig, (err, stats) ->
    cb err

gulp.task 'sync', ->
  browserSync
    proxy: "http://localhost:#{config.port}"
    port: 9091
    open: false

gulp.task 'reload', (cb) ->
  browserSync.reload cb

gulp.task 'server', (cb) ->
  watcher = nodemon
    script: './server'
    watch: ['./server']
    ext: 'js json coffee'

  watcher.once 'start', cb
  watcher.on 'start', ->
    setTimeout browserSync.reload, 1000

names = ['bundle', 'server', 'sync']

for task of tasks
  do (task) ->
    names.push task
    gulp.task task, ->
      gulp
        .src tasks[task].src
        .pipe gulp.dest tasks[task].dest
        .pipe browserSync.reload stream: true
    if tasks[task].watch
      gulp.watch tasks[task].src, gulp.parallel task

gulp.watch "#{webpackConfig.entry}/**/*.coffee", gulp.series 'bundle', 'reload'

gulp.task 'default', gulp.parallel names
