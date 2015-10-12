var path = require('path');
var nib = require('nib');
var webpack = require('webpack');

module.exports = {
  debug: true,
  devtool: 'eval',
  cache: true,
  entry: './client/',
  output: {
    path: __dirname + '/public',
    filename: 'index.js',
    sourceMapFilename: '[file].map'
  },
  module: {
    loaders: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader'
      },
      {
        test: /\.styl$/,
        loader: 'style-loader!css-loader!stylus-loader'
      }
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      sourceMap: true,
      compress: {
        warnings: false,
      },
      output: {
        comments: false,
        semicolons: true,
      }
    })
  ],
  resolve: {
    extensions: [
      '',
      '.coffee',
      '.js',
      '.styl'
    ],
    alias: {
      client: path.resolve(__dirname, 'client')
    },
  },
  stylus: {
    use: [nib()]
  }
};
