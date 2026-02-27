<template>
  <ion-page>
    <ion-content class="ion-padding">

      <h2>Login</h2>

      <ion-input
        label="Email"
        label-placement="floating"
        v-model="email"
      />

      <ion-input
        label="Password"
        label-placement="floating"
        type="password"
        v-model="password"
      />

      <ion-button expand="block" @click="login">
        Login
      </ion-button>

      <ion-text color="danger" v-if="error">
        {{ error }}
      </ion-text>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonContent,
  IonInput,
  IonButton,
  IonText
} from '@ionic/vue'

import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()

const email = ref('')
const password = ref('')
const error = ref('')

const login = async () => {
  try {
    const res = await axios.post('http://localhost/api_mobile/login.php', {
      email: email.value,
      password: password.value
    })

    if (res.data.status === 'success') {
      const user = res.data.data
      localStorage.setItem('user', JSON.stringify(user))
      
      if (user.role === 'admin') {
        router.push('/home')
      } else if (user.role === 'kasir') {
        router.push('/kasir')
      } else if (user.role === 'chef') {
        router.push('/chef')
      } else {
        router.push('/home') // fallback
      }

    } else {
      error.value = res.data.msg
    }

  } catch (err) {
    error.value = 'Gagal terhubung ke server'
  }
}
</script>