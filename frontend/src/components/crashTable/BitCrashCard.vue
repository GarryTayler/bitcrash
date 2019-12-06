<template>
  <div class="bit-crash-card" :class="shadow ? 'is-shadow' : 'is-none-shadow'">
    <div v-if="$slots.header || header" class="bit-crash-header">
      <slot name="header">{{ header }}</slot>
      <!-- <b-col md="8" lg="8" sm="6" class="bit-crash-title">4 in games</b-col>
        <b-col md="4" lg="4" sm="6" class="bit-crash-title">
          <coin-label></coin-label>
        </b-col> -->
    </div>
    <div class="bit-crash-content" :style="bodyStyle">
      <slot />
    </div>
  </div>
</template>

<script>
// import BitCrashTable from '@/components/cashTable/BitCrashTable.vue';
// import CoinLabel from '@/components/cashTable/CoinLabel.vue';

export default {
  name: 'BitCrashCard',
  components: {
    // BitCrashTable,
    // CoinLabel,
  },
  props: {
    header: {},
    bodyStyle: {},
    shadow: {
      type: Boolean,
      default: true
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";

  .bit-crash-card {
    position: relative;
    border-radius: $card-border-radius;
    // display: block;
    // margin: 20px;

    .bit-crash-content{
      border-bottom-left-radius: $card-border-radius;
      border-bottom-right-radius: $card-border-radius;
      background-color: #313d67;
      // min-height: 200px;
      // max-height: 360px;
      // overflow-y: auto;
    }

    // .bit-crash-title {
    //   padding-top:9px;
    // }
  }
  .is-shadow {
    box-shadow: 0 10px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  }
  .is-none-shadow {
  }
</style>
