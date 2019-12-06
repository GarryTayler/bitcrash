<template>
  <b-container fluid class="bg-dark py-4 footer" style="background-color: #384779;">
    <b-row no-gutters align-v="end" class="content">
      <div class="brand">
        <img src="@/assets/img/brand_logo.png" class="d-none d-lg-inline logo mr-lg-3">
        <img src="@/assets/img/brand_text.png" class="d-none d-lg-inline text">
      </div>

      <b-row no-gutters class="ml-lg-auto link-list">
        <div v-show="false" class="link">
          <a href="#" class="text-light mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-about')">WHO ARE WE</a>
          <a href="#" class="text-light mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-together')">WORKING WITH US</a>
          <a href="#" class="text-light mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-industry')">INDUSTRY PARTNERS</a>
          <a href="#" class="text-light mr-lg-4 mr-xl-5" @click.prevent="contactUs()">CONTACT US</a>
        </div>

        <div class="social">
          <a href="#" class="text-light mr-3">
            <img src="@/assets/img/iconmonstr-linkedin.svg">
          </a>
          <a href="#" class="text-light mr-3">
            <img src="@/assets/img/iconmonstr-instagram.svg">
          </a>
          <a href="#" class="text-light mr-3">
            <img src="@/assets/img/iconmonstr-twitter.svg">
          </a>
          <a href="#" class="text-light">
            <img src="@/assets/img/iconmonstr-facebook.svg">
          </a>
        </div>
      </b-row>
    </b-row>

    <div class="copyright">2019 &copy; BITCRASH SYSTEMS</div>
    <div class="copyright">ALL RIGHTS RESERVED</div>
  </b-container>
</template>

<script>
import navigation from '@/mixins/navigation'

export default {
  mixins: [navigation]
}
</script>
