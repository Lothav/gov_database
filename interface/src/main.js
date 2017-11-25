// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import OrgDatabasePage from './OrgDatabasePage'
import 'animate.css/animate.css'
import AnimatedVue from 'animated-vue'
Vue.use(AnimatedVue)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#main-page',
  template: '<org-database-page/>',
  components: { OrgDatabasePage }
})
