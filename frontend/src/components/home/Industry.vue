<template>
  <div class="section-industry">
    <b-row no-gutters>
      <b-col class="text" cols="12" md="8" order="2" order-md="1">
        <h2 class="text-warning">
          INDUSTRIES
          <span class="spacer" />
          WE WORK WITH
        </h2>

        <h3>
          It is critical that you find the right partner who can not only bring
          forward best in class solutions but also integrate and implement
          using some of the most cutting edge and technologically
          advanced network security products in the world.
        </h3>

        <p>
          We know the value in bringing something new to the table that becomes our
          clients business advantage – this is why we have some of the most highly
          trained and experienced professionals on our team.
        </p>
      </b-col>

      <b-col class="image" cols="12" md="4" order="1" order-md="2">
        <img src="@/assets/img/IMAGE_D.png">
      </b-col>
    </b-row>

    <b-row class="list" no-gutters>
      <b-col cols="12" md="6">
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_FINANCE.svg">
          </div>
          FINANCE
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_LEGAL.svg">
          </div>
          LEGAL
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_RETAIL.svg" class="sm">
          </div>
          RETAIL
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_MANU.svg" class="sm">
          </div>
          MANUFACTURING
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_TRANSPORT.svg" class="sm">
          </div>
          TRANSPORT
        </div>
      </b-col>
      <b-col cols="12" md="6">
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_HEALTHCARE.svg">
          </div>
          HEALTHCARE
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_EDU.svg">
          </div>
          EDUCATION
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_ENERGY.svg">
          </div>
          ENERGY/<br class="d-sm-none">GAS/MINING
        </div>
        <div class="d-flex align-items-center mb-3">
          <div class="icon">
            <img src="@/assets/img/ICON_HOSP.svg">
          </div>
          HOSPITALITY/<br class="d-sm-none">HOTEL
        </div>
      </b-col>
    </b-row>

    <app-sidebar class="right bottom" section="industry" />
  </div>
</template>

<script>
import AppSidebar from '@/components/layouts/Sidebar.vue'

export default {
  components: {
    AppSidebar
  }
}
</script>
