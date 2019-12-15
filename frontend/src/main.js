import 'core-js/stable'
import 'regenerator-runtime/runtime'
import Vue from 'vue'
import Cookies from 'js-cookie'

import Element from 'element-ui'
import './assets/scss/element-variables.scss'

import BootstrapVue from 'bootstrap-vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCaretRight, faChevronDown, faChevronLeft, faChevronRight, faChevronUp, faPaperPlane } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import App from './App.vue'
import CxltToastr from 'cxlt-vue2-toastr'
import Loading from 'vue-loading-overlay'
import 'vue-loading-overlay/dist/vue-loading.css'
import 'cxlt-vue2-toastr/dist/css/cxlt-vue2-toastr.css'
import './assets/scss/main.scss'

// import './registerServiceWorker'
import router from './router'
import store from './store'

import './icons' // icon
import './permission' // permission control
import * as filters from './filters' // global filters

library.add(faCaretRight)
library.add(faChevronDown)
library.add(faChevronUp)
library.add(faChevronLeft)
library.add(faChevronRight)
library.add(faPaperPlane)
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(Element, {
  size: Cookies.get('size') || 'medium' // set element-ui default size
})
Vue.use(BootstrapVue)
Vue.use(Loading)
Vue.use(CxltToastr)

Vue.config.productionTip = false

// register global utility filters
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
