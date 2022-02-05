import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '../views/Home'
import RedirectPage from '../views/RedirectPage'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/:shortId',
    name: 'RedirectPage',
    component: RedirectPage
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
