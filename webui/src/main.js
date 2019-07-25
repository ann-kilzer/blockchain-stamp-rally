import Vue from 'vue';
import App from './App.vue';
import Vuetify from 'vuetify';
import colors from 'vuetify/es5/util/colors';

Vue.config.productionTip = false;

Vue.use(Vuetify, {
  theme: {
    primary: colors.blue.darken1,
    secondary: colors.orange.lighten5,
    accent: colors.red.accent3
  }
});

/* eslint-disable no-undef */
let StampRallyJson = require('./StampRally.json');
/* esline-enable no-undef */

new Vue({
  el: '#app',
  data () {
    return {
      json: StampRallyJson
    };
  },
  render: h => h(App)
});
