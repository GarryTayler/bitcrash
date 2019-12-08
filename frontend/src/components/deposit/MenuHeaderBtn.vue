<template>
  <div class="menu-header-btn flex-row-hc-vc" @click="btnClick">
    <img src="@/assets/img/ic_left.png" v-if="type == 0">
    <img src="@/assets/img/ic_bell.png" v-if="type == 1">
  </div>
</template>

<script>

export default {
  name: 'MenuHeaderBtn',
  components: {
  },
  props: {
    type: {
      type: Number,
      default: 0
    }
  },
  methods: {
    btnClick() {
      this.$emit('click')
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.menu-header-btn {
  cursor: pointer;
  height: 100%;
  padding-left: $menu-padding-left-right;
  padding-right: $menu-padding-left-right;
  background-color: transparent;
  &:hover {
      background-color: rgba(0, 0, 0, 0.1)
  }
}
</style>
