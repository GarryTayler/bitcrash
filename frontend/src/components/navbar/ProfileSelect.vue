<template>
  <div class="flex-row-hl-vc p-l-r">
    <img class="profile-img" alt="avatar" src="@/assets/img/IMAGE_C.png">
    <div class="m-l">
      <div class="profile-name">{{ avatarName }}</div>
      <div class="bit-text">bits {{ avatarBits }}</div>
    </div>
    <font-awesome-icon class="down m-l" icon="chevron-down" />
  </div>
</template>

<script>

export default {
  name: 'ProfileSelect',
  components: {
  },
  props: {
    avatarUrl: {
      type: String,
      default: '@/assets/img/avatar-sample.png'
    },
    avatarName: {
      type: String,
      default: ''
    },
    avatarBits: {
      type: Number,
      default: 0
    }
  }
}
</script>
<style lang="scss" scoped>
@import '~@/assets/scss/_variables.scss';
.m-l {
  margin-left: 15px;
}
.profile-name {
  color: $navbar-text-color;
  font-size: $navbar-text-size;
  font-weight: bold;
  max-width: 200px;
}
.p-l-r {
  padding-left: 10px;
  padding-right: 10px;
}
.bit-text {
  color: $navbar-profile-text-color;
  font-size: $navbar-text-size;
  font-weight: bold;
  margin-top: 5px;
}
.down {
  color: $navbar-text-color;
}
</style>
