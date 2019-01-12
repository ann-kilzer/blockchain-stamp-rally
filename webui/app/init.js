import Vue from 'vue'
//import Vuetify from 'vuetify'

import App from './App.vue'


console.log("test")

//Vue.use(Vuetify)

let app = new Vue({
    el: '#app',
    render: h => h(App)
});
