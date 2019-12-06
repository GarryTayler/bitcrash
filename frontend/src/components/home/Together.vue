<template>
  <div class="section-together">
    <div class="content">
      <h1 class="text-warning d-md-flex">
        <div class="mr-3">Working</div>
        <div class="highlight">together</div>
      </h1>

      <h3 class="text-light">
        Our unique process provides personalized cyber security
        solutions, custom-fit to suit your business success.
      </h3>

      <p class="text-light">
        Through a multilayered cyber resilience program that addresses a combination
        of defenses for your organization, employees, customers and partners.
      </p>
    </div>

    <app-sidebar class="left" section="together" />
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
