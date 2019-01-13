import Vue from 'vue'
import Router from 'vue-router'
import StampRally from '../components/StampRally'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'StampRally',
      component: StampRally
    }
  ]
})
