const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

// Bootstrap 3 has a dependency over jQuery:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)

environment.loaders.append('vue', vue)
module.exports = environment
