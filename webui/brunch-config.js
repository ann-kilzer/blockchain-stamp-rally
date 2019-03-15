/* eslint-disable no-undef */
module.exports = {
  files: {
    javascripts: {
      joinTo: {
        'vendor.js': /^(?!app)/,
        'app.js': /^app/
      }
    },
    templates: {
      joinTo: 'app.js'
    },
    stylesheets: {
      joinTo: {
        'css/app.css' : ['app/css/styles.css'],
        'css/vendor.css' : /^node_modules/,
      }
    }
  },
  plugins: {
    babel: {
      presets: ['es2015']
    }
  },
  npm: {
    enabled: true,
    styles: {
      'vuetify': ['dist/vuetify.css'],
      'typeface-roboto': ['index.css']
    },
  },
};
