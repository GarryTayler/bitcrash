import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: () => import('../layouts/Main.vue'),
    children: [
      { path: '/', redirect: '/home' },
      {
        path: '/home',
        component: () => import('../views/Home.vue')
      },
      {
        path: '/deposit',
        component: () => import('../views/deposit.vue')
      },
      {
        path: '/referral',
        component: () => import('../views/Referral.vue')
      }
    ]
  }
]

// const router = new VueRouter({
//   mode: 'history',
//   base: process.env.BASE_URL,
//   routes
// })
const createRouter = () => new VueRouter({
  // // mode: 'history', // require service support
  // scrollBehavior: () => ({ y: 0 }),
  // routes: constantRoutes
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
