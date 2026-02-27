<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-buttons slot="start">
          <ion-menu-button></ion-menu-button>
        </ion-buttons>
        <ion-title>Admin - User Management</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding" color="light">
      <ion-searchbar placeholder="Cari pengguna..."></ion-searchbar>
      
      <ion-list inset="true">
        <ion-list-header>
          <ion-label>Daftar Admin & Karyawan</ion-label>
          <ion-button @click="openAddModal">Tambah Baru</ion-button>
        </ion-list-header>

        <ion-item v-for="user in users" :key="user.id">
          <ion-avatar slot="start">
            <img :src="user.avatar" />
          </ion-avatar>
          <ion-label>
            <h2>{{ user.nama_karyawan }}</h2>
            <p>{{ user.email }} • <ion-text color="primary">{{ user.role }}</ion-text></p>
          </ion-label>
          <ion-badge :color="user.status === 'aktif' ? 'success' : 'medium'" slot="end">{{ user.status }}</ion-badge>
        </ion-item>
      </ion-list>

      <!-- MODAL TAMBAH USER -->
      <ion-modal :is-open="showModal">
        <ion-header>
          <ion-toolbar>
            <ion-title>Tambah Pengguna Baru</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="showModal = false">Batal</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>

        <ion-content class="ion-padding">
          <ion-input v-model="form.nama_karyawan" label="Nama Lengkap" label-placement="floating"></ion-input>
          <ion-input v-model="form.email" label="Email" type="email" label-placement="floating"></ion-input>
          
          <ion-input v-model="form.password" label="Password Baru" type="password" label-placement="floating"></ion-input>

          <ion-select v-model="form.role" label="Jabatan / Role" label-placement="floating">
            <ion-select-option value="admin">Admin</ion-select-option>
            <ion-select-option value="kasir">Kasir</ion-select-option>
            <ion-select-option value="chef">Chef</ion-select-option>
          </ion-select>

          <ion-button expand="block" class="ion-margin-top" @click="saveUser">
            Simpan Karyawan
          </ion-button>
        </ion-content>
      </ion-modal>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'
import {
  IonPage,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonMenuButton,
  IonSearchbar,
  IonList,
  IonListHeader,
  IonItem,
  IonLabel,
  IonAvatar,
  IonButton,
  IonModal,
  IonInput,
  IonSelect,
  IonSelectOption,
  IonBadge,
  IonText
} from '@ionic/vue'

const users = ref([])
const showModal = ref(false)

const form = ref({
  nama_karyawan: '',
  email: '',
  password: '',
  role: ''
})

const loadUsers = async () => {
  try {
    const res = await axios.get('http://localhost/Api_Mobile/admin_get_users.php')
    if(res.data.status === 'success') {
      users.value = res.data.data
    }
  } catch (error) {
    console.error("Error loading users:", error)
  }
}

const openAddModal = () => {
  form.value = {
    nama_karyawan: '',
    email: '',
    password: '',
    role: ''
  }
  showModal.value = true
}

const saveUser = async () => {
  if (!form.value.nama_karyawan || !form.value.email || !form.value.password || !form.value.role) {
    alert("Mohon lengkapi semua data")
    return
  }
  
  try {
    const response = await axios.post('http://localhost/Api_Mobile/admin_save_user.php', form.value)
    if(response.data.status === 'success') {
      showModal.value = false
      loadUsers()
    } else {
      alert(response.data.message || "Gagal menyimpan")
    }
  } catch (error) {
    console.error("Save error:", error)
    alert(error.response?.data?.message || "Terjadi kesalahan server")
  }
}

onMounted(() => {
  loadUsers()
})
</script>
