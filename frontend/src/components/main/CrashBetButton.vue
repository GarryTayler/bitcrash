<template>
  <div class="bg flex-space-between-vc" :class="isDisabled ? 'disabled' : ''" @click="click">
    <span class="text" :class="'text-' + size">{{text}}</span>
    <img src="@/assets/img/ic_bet.png">
  </div>
</template>

<script>

export default {
  name: 'CrashBetButton',
  props: {
    text: {
      type: String,
      default: 'BET'
    },
    isDisabled: {
      type: Boolean,
      default: false
    },
    size: {
      type: String,
      default: 'large'
    }
  },
  components: {
  },
  methods: {
    click() {
      this.$emit('click')
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.bg {
  cursor: pointer;
  height: $control-height;
  width: 100%;
  padding-left: $control-padding-left-right;
  padding-right: $control-padding-left-right;
  background: linear-gradient(90deg, #ffcc00, #ffa914);
  border-radius: $control-border-radius;
  box-shadow: $crash-box-shadow;
  &:hover {
    background: linear-gradient(90deg, #cca300, #cc8710);
  }
  .text {
    color: white;
  }
  .text-small {
    font-size: 14px;
  }
  .text-large {
    font-size: 24px;
    font-weight: bold;
  }
  .text-normal {
    font-size: 18px;
    font-weight: bold;
  }
  &.disabled {
    background: linear-gradient(90deg, #cca300, #cc8710);
    &:hover {
      background: linear-gradient(90deg, #cca300, #cc8710);
    }
  }
}
</style>
