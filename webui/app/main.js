import Vue from 'vue'
import App from './App'
import router from './router'
import Vuetify from 'vuetify'
import colors from 'vuetify/es5/util/colors'

Vue.config.productionTip = false

Vue.use(Vuetify, {
  theme: {
    primary: colors.blue.darken1,
    secondary: colors.orange.lighten5,
    accent: colors.red.accent3
  }
})

let StampRallyJson = require('./StampRally.json');

/* eslint-disable no-new */
new Vue({
    el: '#app',
    data () {
      return {
        json: StampRallyJson
      }
    },
    router,
    render: h => h(App)
})
