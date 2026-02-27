<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-title>Chef Panel</ion-title>
        <ion-buttons slot="end">
          <ion-button color="light" @click="logout" fill="clear">
            Logout
          </ion-button>
        </ion-buttons>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding" color="light">
      <div v-if="orders.length === 0" class="ion-text-center ion-padding" style="margin-top: 50px; color: gray;">
        <h2>Belum ada pesanan masuk</h2>
        <p>Anda bisa bersantai sejenak! ☕</p>
      </div>

      <ion-grid v-else>
        <ion-row>
          <ion-col size="12" size-md="6" size-lg="4" v-for="group in groupedOrders" :key="group.id_order">
            <ion-card class="order-card">
              <ion-card-header>
                <ion-card-subtitle>
                  Pesanan: <strong>{{ group.metode_pesanan === 'dinein' ? `Meja ${group.nomor_meja}` : 'Bawa Pulang' }}</strong>
                </ion-card-subtitle>
                <ion-card-title>{{ group.nama_konsumen }}</ion-card-title>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 8px;">
                  <p style="font-size: 12px; color: gray; margin: 0;">Waktu: {{ formatTime(group.detail_time) }}</p>
                  <ion-badge color="warning" style="font-size: 11px;">
                    ⏳ {{ calculateDuration(group.detail_time) }}
                  </ion-badge>
                </div>
              </ion-card-header>

              <ion-list lines="full">
                <ion-item v-for="item in group.items" :key="item.id_detail">
                  <ion-thumbnail slot="start">
                    <img v-if="item.foto" :src="'http://localhost/Api_Mobile/uploads/' + item.foto" />
                  </ion-thumbnail>
                  <ion-label class="ion-text-wrap">
                    <h3 style="font-weight: bold; margin-bottom: 4px;">{{ item.nama_menu }} <span style="color: var(--ion-color-danger);">x {{ item.jumlah }}</span></h3>
                    <div class="notes" v-if="item.catatan">
                      {{ item.catatan }}
                    </div>
                  </ion-label>
                  <ion-button slot="end" size="small" color="success" style="--border-radius: 8px; font-weight: bold;" @click="markAsDone(item.id_detail)">
                    Selesai
                  </ion-button>
                </ion-item>
              </ion-list>
            </ion-card>
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
  IonList,
  IonItem,
  IonThumbnail,
  IonLabel,
  alertController
} from '@ionic/vue'
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { toast } from 'vue3-toastify'

const router = useRouter()
const orders = ref([])
const now = ref(new Date())
let pollingInterval
let timerInterval

const groupedOrders = computed(() => {
  const groups = {}
  orders.value.forEach(order => {
    if (!groups[order.id_order]) {
      groups[order.id_order] = {
        id_order: order.id_order,
        nama_konsumen: order.nama_konsumen,
        metode_pesanan: order.metode_pesanan,
        nomor_meja: order.nomor_meja,
        detail_time: order.detail_time,
        items: []
      }
    }
    groups[order.id_order].items.push(order)
  })
  return Object.values(groups)
})

const loadOrders = async () => {
  try {
    const res = await axios.get('http://localhost/Api_Mobile/chef_get_orders.php')
    if (res.data.status === 'success') {
      orders.value = res.data.data
    }
  } catch (error) {
    console.error("Error fetching orders:", error)
  }
}

const markAsDone = async (id_detail) => {
  const alert = await alertController.create({
    header: 'Konfirmasi',
    message: 'Tandai pesanan ini sudah selesai dimasak?',
    buttons: [
      {
        text: 'Batal',
        role: 'cancel'
      },
      {
        text: 'Ya, Selesai!',
        handler: async () => {
          try {
            const res = await axios.post('http://localhost/Api_Mobile/chef_update_status.php', { id_detail })
            if (res.data.status === 'success') {
              orders.value = orders.value.filter(o => o.id_detail !== id_detail)
              presentToast('Pesanan telah selesai disiapkan!', 'success')
            } else {
              presentToast(res.data.message, 'error')
            }
          } catch (error) {
            console.error(error)
            presentToast('Terjadi kesalahan sistem.', 'error')
          }
        }
      }
    ]
  });

  await alert.present();
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

const formatTime = (datetimeStr) => {
  if (!datetimeStr) return ''
  const date = new Date(datetimeStr)
  return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
}

const calculateDuration = (startTimeStr) => {
  if (!startTimeStr) return '0m'
  const start = new Date(startTimeStr).getTime()
  const diff = now.value.getTime() - start
  
  const minutes = Math.floor(diff / 60000)
  const seconds = Math.floor((diff % 60000) / 1000)
  
  if (minutes > 0) {
    return `${minutes}m ${seconds}s`
  }
  return `${seconds}s`
}

const logout = () => {
  localStorage.removeItem('user')
  router.replace('/login')
}

onMounted(() => {
  loadOrders()
  // Refresh orders every 10 seconds to catch new kasir inputs
  pollingInterval = setInterval(loadOrders, 10000) 
  // Update current time every second for the duration timer
  timerInterval = setInterval(() => {
    now.value = new Date()
  }, 1000)
})

onUnmounted(() => {
  if(pollingInterval) clearInterval(pollingInterval)
  if(timerInterval) clearInterval(timerInterval)
})
</script>

<style scoped>
.order-card {
  margin: 0;
  height: 100%;
  display: flex;
  flex-direction: column;
}
</style>
