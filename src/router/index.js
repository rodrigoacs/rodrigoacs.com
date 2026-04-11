import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/projects',
      name: 'projects',
      component: () => import('../views/Projects.vue')
    },
    {
      path: '/blog',
      name: 'blog',
      component: () => import('../views/Blog.vue')
    },
    {
      path: '/cv',
      name: 'cv',
      component: () => import('../views/CV.vue')
    },
    {
      path: '/settings',
      name: 'settings',
      component: () => import('../views/Settings.vue')
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: () => import('../views/NotFound.vue')
    }
  ]
})

export default router