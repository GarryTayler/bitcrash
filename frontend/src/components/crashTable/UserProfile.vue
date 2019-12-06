<template>
  <div class="d-flex align-items-center">
    <div class="icon p-r-15">
      <img src="@/assets/img/IMAGE_C.png"/>
      <!-- <img :src="user.url"/> -->
    </div>
    {{user.name}}
  </div>
</template>

<script>
export default {
  name: 'UserProfile',
  components: {},
  props: {
    user: {
      type: Object,
      default: function() {
        return {}
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
  .p-r-15 {
    padding-right: 15px;
  }
  img {
    width: $user-tbl-profile-size;
    border-radius: $navbar-profile-border-radius;
  }
</style>
