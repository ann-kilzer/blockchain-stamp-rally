import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import colors from 'vuetify/es5/util/colors';
import App from './App.vue';
import 'vuetify/src/stylus/app.styl';

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
  data() {
    return {
      json: StampRallyJson,
    };
  },
  render: h => h(App),
}).$mount('#app');
