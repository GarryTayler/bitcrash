<template>
  <div class="section-about">
    <div class="content">
      <b-row no-gutters class="position-relative">
        <div class="image">
          <div class="line"></div>
        </div>

        <h3 class="text-light">
          In the face of an evolving and complex <b>digital environment</b>,
          smart companies who are focused on their <b>core business</b> and
          always <b>innovating</b>, look to us to manage their networks to secure
          a successful future.
        </h3>

        <p class="text-light">
          Since 2004, we have become a <b>reputable</b> name in the industry especially
          known for our <b>breadth of knowledge</b>, <b>our ability to listen intently and
          accurately assess the needs of our clients</b>, and our commitment to
          implement the best-fit solutions at highly competitive rates.
        </p>

        <div class="quote">For Us It's Personal.</div>
      </b-row>
    </div>

    <app-sidebar class="right" section="about"></app-sidebar>
  </div>
</template>

<script>
import AppSidebar from '@/components/layouts/Sidebar.vue';

export default {
  components: {
    AppSidebar,
  },
};
</script>
