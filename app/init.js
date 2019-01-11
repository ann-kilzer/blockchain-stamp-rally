import Vue from 'vue'
import Vuetify from 'vuetify'

import App from './App'

console.log("test")

Vue.use(Vuetify)

const app = new Vue({
    el: '#app',
    render: h => h(App)
});
