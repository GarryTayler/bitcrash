<template>
  <div>
    <div v-if="label == ''" class="caption">
      {{ label }}
    </div>
    <div class="bg flex-space-between-vc">
      <input
        v-model="currentValue"
        class="text"
        name="quantity"
        min="0"
        max="10000000"
        :disabled="disabled"
        @focus="handleFocus"
        @blur="handleBlur"
        @input="handleInput"
      >
      <span class="sup">{{ sup }}</span>
    </div>
  </div>

</template>

<script>

export default {
  name: 'CrashBetButton',
  components: {
  },
  props: {
    label: {
      type: String,
      default: ''
    },
    sup: {
      type: String,
      default: ''
    },
    value: [String, Number],
    disabled: Boolean
  },
  data() {
    return {
      currentValue: this.value,
      focus: false
    }
  },
  watch: {
    value(newValue) {
      this.currentValue = newValue
    }
  },
  methods: {
    handleInput(event) {
      const value = event.target.value
      this.$emit('input', value)
      this.$emit('change', value)
    },
    handleFocus(event) {
      this.focus = true
      this.$emit('focus', event)
    },
    handleBlur(event) {
      this.focus = false
      this.$emit('blur', event)
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.caption {
  font-size: $control-label-text-size;
  color: $navbar-text-color;
  font-weight: bold;
  margin-bottom: 5px;
}
.bg {
  height: $control-height;
  width: 100%;
  padding-left: $control-padding-left-right;
  padding-right: $control-padding-left-right;
  background: #424f73;
  border-radius: $control-border-radius;
  .text {
    font-size: 18px;
    color: white;
    border: none;
    background: none;
    width: 100%;
    margin-right: 10px;
    &:focus{
      outline-color: transparent;
    }
  }
  .sup {
    font-size: 18px;
    color: $control-sup-text-color;
    font-weight: bold;
  }
}
</style>
