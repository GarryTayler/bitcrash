import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

/* Admin Layout */
import AdminLayout from '@/layouts/AdminMain'

export const constantRoutes = [
  {
    path: '/',
    component: () => import('../layouts/Main.vue'),
    children: [
      { path: '/', redirect: '/home' },
      {
        path: '/home',
        component: () => import('../views/Home.vue'),
        meta: { title: '' }
      },
      {
        path: '/deposit',
        component: () => import('../views/deposit.vue'),
        meta: { title: 'Deposit' }
      },
      {
        path: '/withdraw',
        component: () => import('../views/withdraw.vue'),
        meta: { title: 'Withdraw' }
      },
      {
        path: '/referral',
        component: () => import('../views/Referral.vue'),
        meta: { title: 'Referral' }
      },
      {
        path: '/faq',
        component: () => import('../views/faq.vue'),
        meta: { title: 'FAQ' }
      },
      {
        path: '/fairness',
        component: () => import('../views/fairness.vue'),
        meta: { title: 'Provably Fair' }
      }
    ]
  },
  {
    path: '/login',
    component: () => import('@/views/admin/login/index'),
    hidden: true
  }
]
export const adminChildRoutes = [
  {
    path: 'dashboard',
    component: () => import('@/views/admin/dashboard/index'),
    name: 'Dashboard',
    meta: {
      title: 'Dashboard',
      icon: 'dashboard'
    }
  },
  {
    path: 'users',
    component: () => import('@/views/admin/users'),
    name: 'Users',
    meta: {
      title: 'Users',
      icon: 'user'
    }
  },
  {
    path: 'setting',
    component: () => import('@/views/admin/setting'),
    name: 'Setting',
    meta: {
      title: 'Setting',
      icon: 'eye-open'
    }
  },
  {
    path: 'bot',
    component: () => import('@/views/admin/bot'),
    name: 'Bot',
    meta: {
      title: 'Bot',
      icon: 'peoples'
    }
  },
  {
    path: 'wallet',
    component: () => import('@/views/admin/wallet/index'), // Parent router-view
    name: 'Wallet',
    meta: { title: 'Wallet', icon: 'money' },
    redirect: '/admin/wallet/deposit',
    children: [
      {
        path: 'deposit',
        component: () => import('@/views/admin/wallet/deposit'),
        name: 'Deposit',
        meta: {
          title: 'Deposit'
        }
      },
      {
        path: 'withdraw',
        component: () => import('@/views/admin/wallet/withdraw'),
        name: 'Withdraw',
        meta: {
          title: 'Withdraw'
        }
      }
    ]
  },
  {
    path: 'crash',
    component: () => import('@/views/admin/crash/index'), // Parent router-view
    name: 'Crash',
    meta: { title: 'Crash', icon: 'star' },
    redirect: '/admin/crash/gamehistory',
    children: [
      {
        path: 'gamehistory',
        component: () => import('@/views/admin/crash/gamehistory'),
        name: 'GameHistory',
        meta: {
          title: 'GameHistory'
        }
      }
    ]
  },
  {
    path: 'faq',
    component: () => import('@/views/admin/faq'),
    name: 'Faq',
    meta: {
      title: 'Faq',
      icon: 'nested'
    }
  }
]
export const adminRoutes = [
  {
    path: '/admin',
    component: AdminLayout,
    redirect: '/admin/dashboard',
    alwaysShow: true,
    name: 'Admin',
    meta: {
      title: 'Admin'
    },
    children: adminChildRoutes
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
  mode: 'hash',
  base: process.env.BASE_URL,
  routes: constantRoutes.concat(adminRoutes)
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
