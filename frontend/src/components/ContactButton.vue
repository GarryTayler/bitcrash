<template>
  <b-button squared variant="warning" class="mt-4 contact-us"
            @click.prevent="contactUs(submit)">
    <span class="mr-4">Contact Us</span>
    <font-awesome-icon icon="caret-right" />
  </b-button>
</template>

<script>
import navigation from '@/mixins/navigation';

export default {
  props: ['submit'],
  mixins: [navigation],
};
</script>
