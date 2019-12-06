<template>
  <div>
    <!-- <app-navbar /> -->
    <gal-navbar />

    <div class="app-container">
      <router-view />
      <app-footer />
    </div>
  </div>
</template>

<script>
// import AppNavbar from '@/components/layouts/Navbar.vue';
import AppFooter from '@/components/layouts/Footer.vue'
import GalNavbar from '@/components/layouts/GalNavbar.vue'

export default {
  components: {
    AppFooter,
    GalNavbar
  }
}
</script>
