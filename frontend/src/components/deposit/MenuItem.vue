<template>
  <div @click="btnClick" class="flex-row-hc-vc menu-item-wrapper">
    <div>
        <div v-if="type=='settings'" class="flex-row-hc-vc">
            <div class=" image">
                <img src="@/assets/img/ic_setting.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_setting_hover.png">
            </div>
        </div>
        <div v-if="type=='referrals'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_referral_menu.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_referral_menu_hover.png">
            </div>
        </div>
        <div v-if="type=='ranking'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_ranking.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_ranking_hover.png">
            </div>
        </div>
        <div v-if="type=='rewards'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_rewards.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_rewards_hover.png">
            </div>
        </div>
        <div v-if="type=='my games'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_games.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_games_hover.png">
            </div>
        </div>
        <div v-if="type=='message'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_msg.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_msg_hover.png">
            </div>
        </div>
        <div v-if="type=='help center'" class="flex-row-hc-vc">
            <div class="image">
                <img src="@/assets/img/ic_help.png">
            </div>
            <div class="image-hover">
                <img src="@/assets/img/ic_help_hover.png">
            </div>
        </div>
        <div class="flex-row-hc-vc text">
            {{type}}
        </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'MenuItem',
  components: {
  },
  computed: {
  },
  props: {
    type: {
      type: String,
      default: 'settings'
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
.menu-item-wrapper {
  cursor: pointer;
  color: $navbar-profile-text-color;
  background-color: transparent;
  font-size: $control-label-text-size;
  font-weight: bold;
  width: 100%;
  height: $menu-item-height;
  &:hover {
    color: white;
    background-color: #2b365c;
    box-shadow: $crash-box-shadow;
    .image-hover {
      display: block;
    }
    .image {
      display: none;
    }
  }
  .text {
    margin-top: 20px;
    text-transform: uppercase;
  }
  .image-hover {
    display: none;
  }
  .image {
    display: block;
  }
}
</style>
