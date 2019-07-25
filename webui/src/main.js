import Vue from 'vue';
import Vuetify from 'vuetify';
import colors from 'vuetify/es5/util/colors';
import App from './App.vue';

Vue.config.productionTip = false;

Vue.use(Vuetify, {
  theme: {
    primary: colors.blue.darken1,
    secondary: colors.orange.lighten5,
    accent: colors.red.accent3,
  },
});

/* eslint-disable no-undef */
const StampRallyJson = require('./StampRally.json');
/* esline-enable no-undef */

new Vue({
  el: '#app',
  data() {
    return {
      json: StampRallyJson,
    };
  },
  render: h => h(App),
});
