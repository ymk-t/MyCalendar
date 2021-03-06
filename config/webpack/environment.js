const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

// vueの設定
environment.loaders.append('vue', vue)

environment.plugins.append('VueLoaderPlugin', new VueLoaderPlugin())

module.exports = environment
