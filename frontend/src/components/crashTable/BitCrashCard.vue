<template>
  <div class="bit-crash-card" :class="customStyle">
    <div v-if="$slots.header || header" class="bit-crash-header">
      <slot name="header">{{ header }}</slot>
      <!-- <b-col md="8" lg="8" sm="6" class="bit-crash-title">4 in games</b-col>
        <b-col md="4" lg="4" sm="6" class="bit-crash-title">
          <coin-label></coin-label>
        </b-col> -->
    </div>
    <div :class="contentStyle">
      <slot />
    </div>
  </div>
</template>
<script>
export default {
  name: 'BitCrashCard',
  components: {
    // BitCrashTable,
    // CoinLabel,
  },
  props: {
    header: {},
    bodyStyle: {
      type: Number,
      default: 0
    },
    shadow: {
      type: Boolean,
      default: true
    },
    hoverBorder: {
      type: Boolean,
      default: false
    },
    noHeader: {
      type: Boolean,
      default: false
    },
    cardType: {
      type: String,
      default: '0'
    }
  },
  computed: {
    customStyle: {
      get() {
        var ret = this.shadow ? 'is-shadow' : 'is-none-shadow'
        ret += this.hoverBorder ? ' hover-bordered' : ''
        return ret
      }
    },
    contentStyle: {
      get() {
        var ret = this.cardType === '1' ? 'bit-log-content' : 'bit-crash-content'
        ret += this.shadow ? ' is-shadow' : ' is-none-shadow'
        ret += this.bodyStyle === 0 ? ' normal-content' : ' special-content'
        ret += !this.noHeader ? '' : ' top-left-border-radius'
        return ret
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
  .bit-crash-card {
    position: relative;
    border-radius: $card-border-radius;
    .bit-crash-content{
      border-bottom-left-radius: $card-border-radius;
      border-bottom-right-radius: $card-border-radius;
      width: 100%;
      height: 100%;
    }
    .bit-log-content {
      border-bottom-left-radius: $card-border-radius;
      border-bottom-right-radius: $card-border-radius;
      width: 100%; overflow-y: auto;
      max-height: calc( (100vh - 85px - 20px - 40px - #{$card-header-height * 2}) / 2 );
    }
    .normal-content {
      background-color: #313d67;
    }
    .special-content {
      background: linear-gradient(180deg, #333f6c, #2a355a)
    }
  }
  .is-shadow {
    box-shadow: 0 10px 16px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  }
  .is-none-shadow {
  }
  .top-left-border-radius {
    border-top-left-radius: $card-border-radius;
    border-top-right-radius: $card-border-radius;
  }
  .hover-bordered {
    border-color: transparent;
    border-style: solid;
    border-width: 1px;
    .bit-crash-content{
      border-top-left-radius: $card-border-radius;
      border-top-right-radius: $card-border-radius;
      // overflow-y: auto;
    }

    &:hover {
      border-color: #62a1fe;
    }
  }
</style>
