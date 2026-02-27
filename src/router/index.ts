import { createRouter, createWebHistory } from '@ionic/vue-router';
import LoginPage from '@/views/LoginPage.vue';
import HomePage from '../views/HomePage.vue';
import UserPage from '../views/UserPage.vue';
import KasirPage from '../views/KasirPage.vue';
import ChefPage from '../views/ChefPage.vue';

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginPage
  },
  {
    path: '/home',
    component: HomePage
  },
  {
    path: '/user',
    component: UserPage
  },
  {
    path: '/kasir',
    component: KasirPage
  },
  {
    path: '/chef',
    component: ChefPage
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
