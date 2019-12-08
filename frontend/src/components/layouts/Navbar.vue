<template>
  <b-navbar toggleable="lg" type="dark" variant="dark" sticky>
    <b-navbar-brand>
      <img src="@/assets/img/brand_logo.png" class="logo mr-sm-3">
      <img src="@/assets/img/brand_text.png" class="text">
    </b-navbar-brand>

    <b-navbar-toggle target="nav-collapse">
      <span class="icon-bar" />
      <span class="icon-bar" />
      <span class="icon-bar" />
    </b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav class="ml-auto">
        <b-nav-item @click.prevent="scrollTo('section-about')">
          WHO ARE WE
        </b-nav-item>
        <b-nav-item @click.prevent="scrollTo('section-together')">
          WORKING WITH US
        </b-nav-item>
        <b-nav-item @click.prevent="scrollTo('section-industry')">
          INDUSTRY PARTNERS
        </b-nav-item>
        <b-nav-item @click.prevent="contactUs()">
          CONTACT US
        </b-nav-item>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
import navigation from '@/mixins/navigation'

export default {
  mixins: [navigation]
}
</script>
