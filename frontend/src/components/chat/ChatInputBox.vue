<template>
  <div class="bg flex-space-between-vc" style="">
      <input
      class="text"
      name="quantity"
      v-model="currentValue"
      :disabled="disabled"
      @focus="handleFocus"
      @blur="handleBlur"
      @input="handleInput"/>
      <img src="@/assets/img/submit.png">
  </div>
</template>

<script>

export default {
  name: 'CrashBetButton',
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
  components: {
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
  width: 100%;
  padding-left: $control-padding-left-right;
  background: #1e2742;
  border-radius: 3px;
  margin-left: 20px;
  margin-right: 20px;

  .text {
    font-size: 18px;
    color: white;
    border: none;
    background: none;
    width: 100%;
    margin-right: 10px;
  }
  .sup {
    font-size: 18px;
    color: $control-sup-text-color;
    font-weight: bold;
  }
}
</style>
