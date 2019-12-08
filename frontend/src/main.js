import 'core-js/stable'
import 'regenerator-runtime/runtime'
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCaretRight, faChevronDown, faChevronLeft, faChevronRight, faChevronUp, faPaperPlane } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import App from './App.vue'
import Loading from 'vue-loading-overlay'
import 'vue-loading-overlay/dist/vue-loading.css'
import './assets/scss/main.scss'
// import './registerServiceWorker'
import router from './router'
import store from './store'

import './permission' // permission control

library.add(faCaretRight)
library.add(faChevronDown)
library.add(faChevronUp)
library.add(faChevronLeft)
library.add(faChevronRight)
library.add(faPaperPlane)
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(BootstrapVue)
Vue.use(Loading)

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
