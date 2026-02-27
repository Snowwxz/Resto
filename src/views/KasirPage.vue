<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-title>Kasir Panel</ion-title>
        <ion-buttons slot="end">
          <ion-button color="light" @click="logout" fill="clear">
            Logout
          </ion-button>
        </ion-buttons>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <ion-grid style="height: 100%;">
        <ion-row style="height: 100%;">
          
          <!-- LEFT SIDE: MENU GRID -->
          <ion-col size="12" size-md="8" style="border-right: 1px solid #e0e0e0; overflow-y: auto;">
            <ion-grid>
              <ion-row>
                <ion-col size="6" size-md="4" size-lg="3" v-for="menu in menus" :key="menu.id">
                  <ion-card class="menu-card" button @click="addToCart(menu)">
                    <img v-if="menu.foto" :src="'http://localhost/Api_Mobile/uploads/' + menu.foto" class="menu-image" />
                    <div v-else class="no-image">No Image</div>
                    <ion-card-header>
                      <ion-card-title style="font-size: 14px;">{{ menu.nama_menu }}</ion-card-title>
                      <ion-card-subtitle color="primary">Rp {{ menu.harga }}</ion-card-subtitle>
                    </ion-card-header>
                    <ion-badge :color="menu.status === 'available' ? 'success' : 'medium'" style="position: absolute; top: 10px; right: 10px;">
                      {{ menu.status }}
                    </ion-badge>
                  </ion-card>
                </ion-col>
              </ion-row>
            </ion-grid>
          </ion-col>

          <!-- RIGHT SIDE: CART & CHECKOUT -->
          <ion-col size="12" size-md="4" style="display: flex; flex-direction: column; overflow-y: auto;">
            <form @submit.prevent="submitOrder">
              <h3 class="ion-padding-horizontal">Struk & Pembayaran</h3>

              <!-- Cart List -->
              <ion-list style="flex-grow: 1;">
                <ion-item v-for="(item, index) in cart" :key="index">
                  <ion-label>
                    <h2>{{ item.nama_menu }}</h2>
                    <p>Rp {{ item.harga }} x {{ item.jumlah }} ({{ item.metode_pesanan }})</p>
                  </ion-label>
                  <div slot="end" style="display: flex; align-items: center; gap: 8px;">
                    <ion-button size="small" fill="clear" color="danger" @click="removeFromCart(index)">
                      <ion-icon name="trash"></ion-icon> X
                    </ion-button>
                  </div>
                </ion-item>
                
                <ion-item v-if="cart.length === 0">
                  <p style="color: grey; text-align: center; width: 100%;">Belum ada pesanan.</p>
                </ion-item>
              </ion-list>

              <!-- Order Details Form -->
              <div class="ion-padding">
                <ion-input v-model="customerName" label="Nama Pelanggan" label-placement="floating" required></ion-input>
                
                <ion-select v-model="orderType" label="Tipe Pesanan" label-placement="floating" required @ionChange="handleOrderTypeChange">
                  <ion-select-option value="takeaway">Bawa Pulang (Takeaway)</ion-select-option>
                  <ion-select-option value="dinein">Makan di Tempat (Dine-In)</ion-select-option>
                </ion-select>

                <ion-input v-if="orderType === 'dinein'" v-model="selectedTable" label="Ketik Nomor Meja" type="text" label-placement="floating" required></ion-input>

                <ion-select v-model="paymentMethod" label="Metode Pembayaran" label-placement="floating" required>
                  <ion-select-option value="cash">Tunai (Cash)</ion-select-option>
                  <ion-select-option value="qris">E-Wallet (QRIS)</ion-select-option>
                </ion-select>

                <div style="display: flex; justify-content: space-between; margin-top: 16px; font-weight: bold; font-size: 18px;">
                  <span>Total Bayar:</span>
                  <span>Rp {{ totalBayar }}</span>
                </div>

                <ion-button expand="block" color="success" class="ion-margin-top" type="submit" :disabled="cart.length === 0">
                  Proses Pembayaran
                </ion-button>
              </div>
            </form>
          </ion-col>

        </ion-row>
      </ion-grid>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonButton,
  IonGrid,
  IonRow,
  IonCol,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardSubtitle,
  IonBadge,
  IonList,
  IonItem,
  IonLabel,
  IonInput,
  IonSelect,
  IonSelectOption,
  IonIcon,
  alertController
} from '@ionic/vue'
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { toast } from 'vue3-toastify'

const router = useRouter()
const menus = ref([])
const tables = ref([])
const cart = ref([])

const customerName = ref('')
const orderType = ref('takeaway') // default to takeaway
const selectedTable = ref('')
const paymentMethod = ref('cash')

const handleOrderTypeChange = () => {
  if (orderType.value === 'takeaway') {
    selectedTable.value = '' // clear table selection if switched to takeaway
  }
}

const user = JSON.parse(localStorage.getItem('user') || '{}')

const totalBayar = computed(() => {
  return cart.value.reduce((total, item) => total + item.subtotal, 0)
})

const loadMenus = async () => {
  try {
    const res = await axios.get('http://localhost/Api_Mobile/admin_get_menu.php')
    if(res.data.status === 'success') {
      menus.value = res.data.data
    }
  } catch (error) { console.error(error) }
}

const loadTables = async () => {
  try {
    const res = await axios.get('http://localhost/Api_Mobile/kasir_get_meja.php')
    if(res.data.status === 'success') {
      tables.value = res.data.data
    }
  } catch (error) { console.error(error) }
}

const addToCart = (menu) => {
  if(menu.status !== 'available') {
    presentToast('Menu sedang Sold Out!', 'warning')
    return
  }

  const metode_pesanan = orderType.value
  
  const existingItemIndex = cart.value.findIndex(item => item.id_menu === menu.id)
  
  if (existingItemIndex !== -1) {
    cart.value[existingItemIndex].jumlah += 1
    cart.value[existingItemIndex].subtotal = cart.value[existingItemIndex].jumlah * cart.value[existingItemIndex].harga
  } else {
    cart.value.push({
      id_menu: menu.id,
      nama_menu: menu.nama_menu,
      harga: menu.harga,
      jumlah: 1,
      subtotal: menu.harga * 1,
      metode_pesanan: metode_pesanan
    })
  }
}

const removeFromCart = (index) => {
  cart.value.splice(index, 1)
}

const submitOrder = async () => {
  if(!customerName.value) {
    presentToast('Nama pelanggan wajib diisi!', 'error')
    return
  }

  try {
    const payload = {
      nama_konsumen: customerName.value,
      id_meja: selectedTable.value || null,
      metode_pembayaran: paymentMethod.value,
      id_user: user.id,
      total_bayar: totalBayar.value,
      cart: cart.value.map(item => ({
        id_menu: item.id_menu,
        jumlah: item.jumlah,
        subtotal: item.subtotal,
        metode_pesanan: orderType.value
      }))
    }

    const res = await axios.post('http://localhost/Api_Mobile/kasir_save_order.php', payload)
    
    if (res.data.status === 'success') {
      presentToast('Pesanan berhasil dibuat!', 'success')
      // Reset form
      cart.value = []
      customerName.value = ''
      orderType.value = 'takeaway'
      selectedTable.value = ''
      paymentMethod.value = 'cash'
      loadMenus() // Refresh menu to get updated stock
      loadTables() // Refresh tables in case it got booked
    } else {
      presentToast(res.data.message, 'error')
    }

  } catch (error) {
    console.error(error)
    presentToast('Terjadi kesalahan saat memproses pesanan', 'error')
  }
}

const presentToast = (message: string, type: 'success' | 'error' | 'warning' | 'info') => {
  toast(message, {
    autoClose: 2000,
    type: type,
    position: 'top-right',
    theme: 'colored',
    transition: 'bounce',
    dangerouslyHTMLString: true
  });
}

const logout = () => {
  localStorage.removeItem('user')
  router.replace('/login')
}

onMounted(() => {
  loadMenus()
  loadTables()
})
</script>

<style scoped>
.menu-card {
  margin: 0;
  height: 100%;
  display: flex;
  flex-direction: column;
  position: relative;
}

.menu-image {
  height: 120px;
  width: 100%;
  object-fit: cover;
}

.no-image {
  height: 120px;
  width: 100%;
  background: #f4f5f8;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #92949c;
  font-weight: bold;
}
</style>
