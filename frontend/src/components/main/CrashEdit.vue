<template>
  <div>
    <div v-if="label != ''" class="caption">
      {{ label }}
    </div>
    <div class="bg flex-space-between-vc">
      <input
        v-model="currentValue"
        :class="{text: true , disabled: disabled}"
        name="quantity"
        min="0"
        max="10000000"
        :disabled="disabled"
        @focus="handleFocus"
        @blur="handleBlur"
        @input="handleInput"
      >
      <span v-if="type==='1'" class="sup sup_event" @click="clear">{{ sup }}</span>
      <span v-if="type==='2'" class="sup sup_label">{{ sup }}</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CrashEdit',
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
    type: {
      type: String,
      default: ''
    },
    // eslint-disable-next-line vue/require-default-prop
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
    clear() {
      this.currentValue = 0
    },
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
    @include media-breakpoint-down(xs) {
      font-size: 14px;
    }
  }
  .sup {
    font-size: 18px;
    color: $control-sup-text-color;
    font-weight: bold;
  }
  .sup_event {
    cursor: pointer;
  }
  .sup_event:hover {
    color: #fff;
  }
  .disabled {
    color: #939fad;
  }
}
</style>
