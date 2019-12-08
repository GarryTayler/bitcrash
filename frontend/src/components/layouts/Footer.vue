<template>
  <b-container fluid class="py-4 footer" style="background-color: #1b2132;">
    <b-row no-gutters align-v="end" class="content">
      <b-row no-gutters class="m-auto link-list">
        <div class="link">
          <a href="#" class="text-link mr-lg-4 mr-xl-5 active" @click.prevent="scrollTo('section-about')">PRIVACY AND SECURITY</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-together')">RESPONSIBLE GAMING</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-industry')">TERMS AND SERVICE</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="contactUs()">AFFILIATE</a>
        </div>
      </b-row>
    </b-row>
    <b-row no-gutters align-v="end" class="content mb-3">
      <b-row class="m-auto link-list">
        <div class="link">
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-about')">FAQ</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-together')">LEGAL</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="scrollTo('section-industry')">PRAVABLY FAIR</a>
          <a href="#" class="text-link mr-lg-4 mr-xl-5" @click.prevent="contactUs()">ABOUT</a>
        </div>
      </b-row>
    </b-row>
    <b-row no-gutters align-v="end" class="content copyright1">
      <b-row class="m-auto link-list">
        Copyright &copy; 2019 bitcrash.com. All rights reserved. This site is not associated with Valve Corp.
      </b-row>
    </b-row>
  </b-container>
</template>

<script>
import navigation from '@/mixins/navigation'

export default {
  mixins: [navigation]
}
</script>

<style lang="scss" scoped>
  .copyright1 {
    border-top: 1px solid #252c41;
    color: #6f778c;
    padding-left: 20px;
    padding-right: 20px;
  }
  .footer {
    padding-left: 0px;
    padding-right: 0px;
  }
  .text-link {
    color: #6f778c;
  }
  .active{
    color: #ffffff;
  }
</style>
