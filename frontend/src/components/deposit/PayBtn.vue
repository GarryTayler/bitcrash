<template>
  <bit-crash-card :hover-border="true" :body-style="1" class="bg">
    <div class="flex-row-hc-vc main-content" @click="btnClick">
      <div>
        <div v-if="type=='skins'" class="flex-row-hc-vc">
          <img src="@/assets/img/ic_pay_skin.png">
        </div>
        <div v-if="type=='bitcoin'" class="flex-row-hc-vc">
          <img src="@/assets/img/ic_pay_bitcoin.png">
        </div>
        <div v-if="type=='alipay'" class="flex-row-hc-vc">
          <img src="@/assets/img/ic_pay_alipay.png">
        </div>
        <div v-if="type=='wechat'" class="flex-row-hc-vc">
          <img src="@/assets/img/ic_pay_wechat.png">
        </div>

        <div class="text-wrapper text-wrapper-hover flex-row-hc-vc">
          <div>{{ text }}</div>
        </div>
      </div>
    </div>
  </bit-crash-card>
</template>

<script>
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'

export default {
  name: 'PayBtn',
  components: {
    BitCrashCard
  },
  props: {
    type: {
      type: String,
      default: 'skins'
    }
  },
  computed: {
    text: {
      get() {
        switch (this.type) {
          case 'skins':
            return 'Skins'
          case 'bitcoin':
            return 'Bitcoin'
          case 'alipay':
            return 'Alipay'
          case 'wechat':
            return 'WeChat Pay'
          default:
            return ''
        }
      }
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
.bg {
  cursor: pointer;
  width: $paybtn-width;
  height: $paybtn-height;
  .main-content {
    width: 100%;
    height: 100%;
  }
  .text-wrapper {
    background-color: #46568c;
    box-shadow: $crash-box-shadow;
    border-radius: $control-border-radius;
    width: $paybtn-text-wrapper-width;
    height: $paybtn-text-wrapper-height;
    text-align: center;

    font-size: $control-label-text-size;
    font-family: bold;
    color: white;

    margin-top: 12px;
  }
  &:hover {
    .text-wrapper-hover {
      background-color: #f7931a !important;
    }
  }
}
</style>
