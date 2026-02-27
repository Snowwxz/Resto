<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-buttons slot="start">
          <ion-menu-button></ion-menu-button>
        </ion-buttons>
        <ion-title>Admin - Management Menu</ion-title>
        <ion-buttons slot="end">
          <ion-button color="light" @click="logout" fill="clear">
            Logout
          </ion-button>
        </ion-buttons>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">

      <ion-button expand="block" @click="openAddModal">
        + Tambah Menu
      </ion-button>

      <ion-grid>
        <ion-row>
          <ion-col size="12" size-md="6" size-lg="4" v-for="menu in menus" :key="menu.id">
            <ion-card class="menu-card">
              <img v-if="menu.foto" :src="'http://localhost/Api_Mobile/uploads/' + menu.foto" class="menu-image" />
              <div v-else class="no-image">No Image</div>
              
              <ion-card-header>
                <ion-card-title>{{ menu.nama_menu }}</ion-card-title>
                <ion-card-subtitle color="primary">Rp {{ menu.harga }}</ion-card-subtitle>
              </ion-card-header>
              
              <ion-card-content>
                <p>Stok: <strong>{{ menu.stok_porsi }} porsi</strong></p>
                <p>Status: <ion-text :color="menu.status === 'available' ? 'success' : 'danger'"><strong>{{ menu.status }}</strong></ion-text></p>
              </ion-card-content>
              
              <ion-row class="ion-padding-horizontal ion-padding-bottom">
                <ion-col>
                  <ion-button expand="block" size="small" color="primary" fill="outline" @click="editMenu(menu)">
                    Edit
                  </ion-button>
                </ion-col>
                <ion-col>
                  <ion-button expand="block" size="small" color="warning" fill="outline" @click="updateStok(menu)">
                    Stok
                  </ion-button>
                </ion-col>
                <ion-col>
                  <ion-button expand="block" size="small" color="danger" fill="outline" @click="hapusMenu(menu.id)">
                    Hapus
                  </ion-button>
                </ion-col>
              </ion-row>
            </ion-card>
          </ion-col>
        </ion-row>
      </ion-grid>

      <!-- MODAL TAMBAH / EDIT -->
      <ion-modal :is-open="showModal">
        <ion-header>
          <ion-toolbar>
            <ion-title>{{ isEdit ? 'Edit Menu' : 'Tambah Menu' }}</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="showModal = false">Tutup</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>

        <ion-content class="ion-padding">
          <ion-input v-model="form.nama_menu" label="Nama Menu" label-placement="floating"></ion-input>
          <ion-input v-model="form.harga" label="Harga" type="number" label-placement="floating"></ion-input>
          <ion-input v-model="form.stok_porsi" label="Stok" type="number" label-placement="floating"></ion-input>

          <ion-select v-model="form.status" label="Status" label-placement="floating">
            <ion-select-option value="available">Available</ion-select-option>
            <ion-select-option value="sold_out">Sold Out</ion-select-option>
          </ion-select>
          
          <div style="margin-top:16px;">
            <label style="color:#808289; font-size: 14px; padding-left:16px;">Foto Menu</label>
            <input type="file" @change="onFileChange" accept="image/*" style="display: block; margin-top: 8px; padding-left:16px;"/>
            <img v-if="form.fotoPreview" :src="form.fotoPreview" style="max-height:100px; margin-top:10px; margin-left:16px; border-radius:8px;" />
          </div>

          <ion-button expand="block" class="ion-margin-top" @click="simpanMenu">
            Simpan
          </ion-button>
        </ion-content>
      </ion-modal>

    </ion-content>
  </ion-page>
</template>

<script setup>
import {
  IonPage,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButton,
  IonList,
  IonItem,
  IonLabel,
  IonModal,
  IonButtons,
  IonInput,
  IonSelect,
  IonSelectOption,
  IonMenuButton,
  IonGrid,
  IonRow,
  IonCol,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardSubtitle,
  IonCardContent,
  IonText
} from '@ionic/vue'
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()

const menus = ref([])
const showModal = ref(false)
const isEdit = ref(false)
const editId = ref(null)

const form = ref({
  nama_menu: '',
  harga: '',
  stok_porsi: '',
  status: 'available',
  fotoBase64: '',
  fotoPreview: ''
})

const onFileChange = (e) => {
  const file = e.target.files[0]
  if(file){
    const reader = new FileReader()
    reader.onload = (e) => {
      form.value.fotoBase64 = e.target.result
      form.value.fotoPreview = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const loadMenu = async () => {
  try {
    const res = await axios.get('http://localhost/Api_Mobile/admin_get_menu.php')
    menus.value = res.data.data
  } catch (error) {
    console.error("Error loading menu:", error)
  }
}

const openAddModal = () => {
  isEdit.value = false
  editId.value = null
  form.value = {
    nama_menu: '',
    harga: '',
    stok_porsi: '',
    status: 'available',
    fotoBase64: '',
    fotoPreview: ''
  }
  showModal.value = true
}

const editMenu = (menu) => {
  isEdit.value = true
  editId.value = menu.id
  form.value = {
    nama_menu: menu.nama_menu,
    harga: menu.harga,
    stok_porsi: menu.stok_porsi,
    status: menu.status,
    fotoBase64: '', 
    fotoPreview: menu.foto ? 'http://localhost/Api_Mobile/uploads/' + menu.foto : ''
  }
  showModal.value = true
}

const simpanMenu = async () => {
  try {
    if (isEdit.value) {
      await axios.post('http://localhost/Api_Mobile/admin_edit_menu.php', {
        id: editId.value,
        ...form.value
      })
    } else {
      await axios.post('http://localhost/Api_Mobile/admin_save_menu.php', form.value)
    }
    showModal.value = false
    loadMenu()
  } catch (error) {
    console.error("Error saving menu:", error)
    alert("Terjadi kesalahan saat menyimpan menu")
  }
}

const hapusMenu = async (id) => {
  await axios.post('http://localhost/Api_Mobile/admin_delete_menu.php', { id })
  loadMenu()
}

const updateStok = async (menu) => {
  const stokBaru = prompt("Masukkan stok baru:", menu.stok_porsi)
  if (stokBaru) {
    await axios.post('http://localhost/Api_Mobile/admin_update_stok.php', {
      id_menu: menu.id,
      jumlah_porsi: stokBaru
    })
    loadMenu()
  }
}

const logout = () => {
  localStorage.removeItem('user')
  router.replace('/login')
}

onMounted(loadMenu)
</script>

<style scoped>
.menu-card {
  margin: 0;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.menu-image {
  height: 200px;
  width: 100%;
  object-fit: cover;
}

.no-image {
  height: 200px;
  width: 100%;
  background: #f4f5f8;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #92949c;
  font-weight: bold;
}

ion-card-content {
  flex-grow: 1;
}
</style> 