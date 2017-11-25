// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import OrgDatabasePage from './OrgDatabasePage'
import AnimatedVue from 'animated-vue'
import BootstrapVue from 'bootstrap-vue'

import 'animate.css/animate.css'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(AnimatedVue)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#main-page',
  template: '<org-database-page/>',
  components: { OrgDatabasePage }
})
