<template>
  <div class="container flex-row-hl-vc">
    <div :class="circleStyle" />
    <div class="text-container">
      <div class="val-text" :class="data.is_active ? 'is-active' : ''">{{ data.val }}</div>
      <div :class="scaleTextStyle">{{ data.scale }}x</div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'CrashHeaderItem',
  components: {
  },
  props: {
    data: {
      type: Object,
      default: function() {
        return {
          id: 0,
          scale: 1.5,
          val: 978513,
          type: 0,
          is_active: false
        }
      }
    }
  },
  data() {
    return {
    }
  },
  computed: {
    scaleTextStyle: {
      get() {
        return (this.data.is_active ? 'is-active' : '') + (' scale-text-' + this.data.type)
      }
    },
    circleStyle: {
      get() {
        return 'circle circle-bg-' + this.data.type
      }
    }
  },
  methods: {
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
.container {
}
.circle {
  width: 35px;
  height: 35px;
  border-radius: 50%;
}
.circle-bg-0 {
    background-color: $crash-header-item-color-0;
}
.circle-bg-1 {
    background-color: $crash-header-item-color-1;
}
.text-container {
  margin-left: 13.5px;
}
.val-text {
  color: $navbar-text-color;
  font-size: 14px;
  font-weight: bold;
}
.scale-text-0 {
  color: $crash-header-item-color-0;
  font-size: 14px;
}
.scale-text-1 {
  color: $crash-header-item-color-1;
  font-size: 14px;
}
.is-active {
}
</style>
