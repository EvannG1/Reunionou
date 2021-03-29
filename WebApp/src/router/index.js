import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store/index.js'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'

Vue.use(VueRouter)

function isLogged() {
  if(!store.state.token) {
    return false;
  } else {
    return true;
  }
}

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  if((to.name !== 'Login' && to.name !== 'Register') && !isLogged()) {
    next({name: 'Login'})
  } else if((to.name == 'Login' || to.name == 'Register') && isLogged()) {
    next({name: 'Home'})
  } else {
    next()
  }
})

export default router