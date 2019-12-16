<template>
  <div class="bg flex-space-between-vc" style="">
    <input
      v-model="currentValue"
      class="text flex1"
      name="quantity"
      :disabled="disabled"
      @keyup.enter="sendMsg"
      @focus="handleFocus"
      @blur="handleBlur"
       @input="handleInput"/>
      <crash-button :icon="text.length > 0 ? '' : 'paper-plane'" @click="sendMsg" :disabled="disabled" :text="text"/>
  </div>
</template>

<script>
import CrashButton from '@/components/ui/CrashButton'

export default {
  name: 'CrashBetButton',
  components: {
    CrashButton
  },
  props: {
    value: [String, Number],
    disabled: Boolean,
    text: {
      type: String,
      default: ''
    }
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
    },
    sendMsg() {
      this.$emit('sendMsg', this.currentValue)
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
  border-radius: $control-border-radius;

  .text {
    font-size: 18px;
    color: white;
    border: none;
    background: none;
    width: 100%;
    margin-right: 10px;
    &:focus {
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
