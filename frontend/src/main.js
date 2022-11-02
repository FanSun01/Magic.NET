// with polyfills
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/'
import { VueAxios } from './utils/request'
// WARNING: `mockjs` NOT SUPPORT `IE` PLEASE DO NOT USE IN `production` ENV.
import './mock'

import bootstrap from './core/bootstrap'
import './core/lazy_use'
import './permission' // permission control
import './utils/filter' // global filter
import './components/global.less'
import socket from './utils/socket'
import { Dialog } from '@/components'
import { hasBtnPermission } from './utils/permissions' // button permission
import { sysApplication } from './utils/applocation'
import KFormDesign from 'k-form-design'
// import KFormDesign from 'k-form-design/lib/k-form-design-mini.umd.min'
import 'k-form-design/lib/k-form-design.css'
import 'ant-design-vue/dist/antd.less'
import dataV from '@jiaminghi/data-view'
import VueContextMenu from 'vue-contextmenu'
import vcolorpicker from 'vcolorpicker'

Vue.use(VueContextMenu)
Vue.use(vcolorpicker)
Vue.use(KFormDesign)
Vue.use(socket, '/hubs/chatHub')
Vue.use(VueAxios)
Vue.use(Dialog)
Vue.use(dataV)
Vue.prototype.hasPerm = hasBtnPermission
Vue.prototype.applocation = sysApplication
Vue.config.productionTip = false

new Vue({
  router,
  store,
  created: bootstrap,
  render: h => h(App)
}).$mount('#app')
