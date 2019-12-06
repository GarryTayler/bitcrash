<template>
  <div class="section-role">
    <b-row no-gutters>
      <b-col class="text" cols="12" md="6" order="2" order-md="1">
        <h2 class="text-warning">OUR ROLE</h2>

        <h3>
          Becoming an integral part of your business
          <span class="spacer"></span>
          starts with a deep understanding of it.
        </h3>

        <p>
          Whether traditional or emerging technologies, on premise or
          migrating to the cloud, we can help you identify and orchestrate
          the best possible solutions, always offering innovative
          recommendations that best fit your environment and needs.
        </p>

        <contact-button></contact-button>
      </b-col>

      <b-col class="image" cols="12" md="6" order="1" order-md="2">
        <img src="@/assets/img/IMAGE_C.png" />
      </b-col>
    </b-row>
  </div>
</template>

<script>
import ContactButton from '@/components/ContactButton.vue';

export default {
  components: {
    ContactButton,
  },
};
</script>
