<template>
  <ion-app>
    <ion-menu content-id="main-content">
      <ion-header>
        <ion-toolbar color="primary">
          <ion-title>Menu</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-content>
        <ion-list>
          <ion-menu-toggle auto-hide="false">
            <ion-item button router-link="/home" router-direction="root">
              <ion-label>Management Menu</ion-label>
            </ion-item>
            <ion-item button router-link="/user" router-direction="root">
              <ion-label>User Management</ion-label>
            </ion-item>
          </ion-menu-toggle>
        </ion-list>
      </ion-content>
    </ion-menu>
    <ion-router-outlet id="main-content" />
  </ion-app>
</template>

<script setup lang="ts">
import { 
  IonApp, 
  IonRouterOutlet,
  IonMenu,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonList,
  IonItem,
  IonLabel,
  IonMenuToggle
} from '@ionic/vue';
</script>
