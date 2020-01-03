<template>
  <div class="root content-padding">
    <b-row align-v="start">
      <div class="w-h m-b-sm">
        <bit-crash-card :body-style="1" :no-header="true">
          <div class="bitcoin-card-content">
            <b-row class="text-center deposit-title">
              <b-col class="label">
                Deposit With Bitcoin
              </b-col>
            </b-row>
            <b-row class="text-center deposit-desc">
              <b-col class="label">
                You will receive coins automatically after sending BTC to the address displayed below.
              </b-col>
            </b-row>
            <b-row class="deposit-input justify-content-md-center">
              <b-col sm="12" md="4" lg="4" xl="4">
                <div>
                  <div class="label m-b-sm">
                    Your personal BTC deposit address
                  </div>
                  <chat-input-box text="Copy Address" readonly class="m-b-sm" />
                </div>
              </b-col>
            </b-row>
            <b-row class="deposit-qrcode justify-content-md-center">
              <b-col sm="12" md="3" lg="3" xl="3">
                <div class="flex-row-hc-vc">
                  <qrcode-vue :value="value" :size="size" level="H" class="qrcode_canvas" />
                </div>
              </b-col>
            </b-row>
            <b-row class="text-center deposit-calc">
              <b-col class="label">
                COIN TO BTC CALCULATOR
              </b-col>
            </b-row>
            <b-row class="deposit-calc-container" align-h="center">
              <b-col sm="12" md="12" lg="12" xl="12">
                <b-row align-h="center" align-v="center">
                  <crash-edit class="deposit-coin" sup="Coin" type="2" :disabled="!is_logged_in" />
                  <div class="text-center label">
                    =
                  </div>
                  <crash-edit class="deposit-btc" sup="BTC" type="2" :disabled="!is_logged_in" />
                </b-row>
              </b-col>
            </b-row>
            <b-row class="text-center deposit-method">
              <b-col class="label">
                Payment via:
              </b-col>
            </b-row>
            <b-row class="text-center justify-content-md-center deposit-bitcoin-logo">
              <b-col>
                <img src="@/assets/img/ic_bitcoin_col.png" class="bitcoin-logo">
              </b-col>
            </b-row>
          </div>
        </bit-crash-card>
      </div>
    </b-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import ChatInputBox from '@/components/chat/ChatInputBox'
import titleMixin from '@/mixins/titleMixin'
import QrcodeVue from 'qrcode.vue'
import CrashEdit from '@/components/main/CrashEdit.vue'

export default {
  name: 'Home',
  title: 'Deposit - Bitcrash',
  components: {
    BitCrashCard,
    ChatInputBox,
    CrashEdit,
    QrcodeVue
    // MenuBar
  },
  mixins: [titleMixin],
  data() {
    return {
    //   menu: true
      value: 'f00484c44b6c457abf570448470af78c',
      size: 200
    }
  },
  computed: {
    ...mapGetters([
      'is_logged_in',
      'wallet',
      'avatar',
      'crash_server_url',
      'user_id',
      'name',
      'token'
    ])
  },
  created: function() {
  },
  methods: {
    payClick(type) {
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";

.deposit-title .label {
    font-weight: bold;
    color: #c9d6e4;
    font-size: 2rem;
    letter-spacing: .025em;
    line-height: 1.25;
}

.deposit-desc {
  margin-top: 13.5px;
}

.deposit-input {
  margin-top: 30px;
}

.deposit-calc {
  margin-top: 30px;
}

.deposit-calc-container {
  margin-top: 30px;
}

.deposit-input .label,
.deposit-desc .label,
.deposit-method .label
 {
  color: #c9d6e4;
  font-weight: 400;
  font-size: .9375rem;
  line-height: 1.5;
}

.deposit-calc .label,
.deposit-calc-container .label {
  color: #c9d6e4;
  font-weight: bold;
  font-size: 1.2rem;
  line-height: 1.5;
}
.deposit-calc-container .label {
  padding: 0px 15px 0px 15px;
}
.deposit-qrcode {
  margin-top: 30px;
}

.qrcode_canvas {
  background: #fff;
  padding: 15px;
}

.bitcoin-logo {
  width: 80px;
  height: 80px;
}

.deposit-method {
  margin-top: 30px;
}

.deposit-bitcoin-logo {
  margin-top: 30px;
}

.root {
  position: relative;
  width: 100%;
}
.with-menu {
  @include media-breakpoint-down(md) {
    padding-left: 50px;
  }
  padding-left: calc(50px + #{$menu-width});
}

.m-b {
  margin-bottom: $normal-margin-bottom-lg;
}
.m-b-sm {
  margin-bottom: $normal-margin-bottom-sm;
}
.m-l {
  margin-left: 15px;
}
.w-h {
    width: 100%;
}

.bitcoin-card-content {
  padding-left: $deposit-card-padding-left-right;
  padding-right: $deposit-card-padding-left-right;
  padding-top: 30px;
  padding-bottom: 30px;
}
// responsive
.content-padding {
  padding-left: 50px;
  padding-top: 20px;
  padding-right: calc(50px + #{$chat-width} + #{$scrollbar-width});
  @include media-breakpoint-down(md) {
    padding-left: 20px;
    padding-right: 20px;
  }
  padding-bottom: 50px;
}
@media (max-width: 991.98px) and (min-width: 321px)
{
  .content-padding {
    padding-right: 20px;
  }
}
@media (max-width: 1600px) and (min-width: 992px)
{
  .content-padding {
    padding-right: calc(50px + 300px + #{$scrollbar-width});
  }
}
@media (min-width: 1600px)
{
  .deposit-coin ,
  .deposit-btc {
    width: 20%;
  }
}
@media (max-width: 1600px) and (min-width: 1200px)
{
  .deposit-coin ,
  .deposit-btc {
    width: 30%;
  }
}

@media (max-width: 1200px) and (min-width: 600px)
{
  .deposit-coin ,
  .deposit-btc {
    width: 35%;
  }
}
@media (max-width: 600px)
{
  .deposit-coin ,
  .deposit-btc {
    width: 40%;
  }
}

</style>
