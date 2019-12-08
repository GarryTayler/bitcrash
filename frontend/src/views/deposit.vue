<template>
  <div class="root content-padding" :class="{'with-menu': menu}">
    <b-row align-v="start">
      <b-col v-for="item in pay_types" :key="item" sm="12" md="6" lg="3" xl="3" class="m-b flex-row-hc-vc">
        <pay-btn :type="item" @click="payClick(item)" />
      </b-col>
      <div class="w-h m-b-sm">
        <bit-crash-card :body-style="1" :no-header="true">
          <div class="bitcoin-card-content">
            <b-row align-v="center">
              <b-col sm="12" md="6" lg="6" xl="6">
                <div class="flex-row-hl-vc bitcoin-content-logo">
                  <img src="@/assets/img/ic_bitcoin_col.png">
                  <span class="label">Bitcoin</span>
                </div>
              </b-col>
              <b-col sm="12" md="6" lg="6" xl="6">
                <div class="flex-row-hc-vc bitcoin-content">
                  <span class="label label-high">-3.68253000 BTC</span>
                  <span class="label m-l">Total Balance</span>
                </div>
              </b-col>
            </b-row>
          </div>
        </bit-crash-card>
      </div>
      <div class="w-h m-b-sm">
        <div class="bitcoin-lbl-card-content">
          <b-row align-v="center">
            <b-col sm="12" md="6" lg="6" xl="6">
              <div />
            </b-col>
            <b-col sm="12" md="6" lg="6" xl="6">
              <div class="flex-row-hc-vc price-content">
                <span class="label-high">-22,244,275</span>
                <span class="label m-l">Total Price (KVR)</span>
              </div>
            </b-col>
          </b-row>
        </div>
      </div>
      <div class="w-h m-b">
        <bit-crash-card :body-style="1" :no-header="true">
          <div class="btc-content bitcoin-tbl-card-content">
            <b-row align-v="center">
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b">
                  <span class="label-1">Daily withdrawal limit  </span>
                  <span class="label-1">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">Withdrawal amount today </span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">-Min, withdrawal amount</span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">-Min, withdrawal amount</span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
              </b-col>
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b">
                  <span class="label-1">On exchange (Open Order) Total sum</span>
                  <span class="label-1">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">- On buy</span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">- On sell</span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-2">- On withdrawal</span>
                  <span class="label-3">150.00000000 BTC</span>
                </div>
              </b-col>
            </b-row>
            <div class="seperator m-b-sm" />
            <b-row align-v="center">
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-1">Daily withdrawal limit  </span>
                  <span class="label-1">150.00000000 BTC</span>
                </div>
              </b-col>
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-1">On exchange (Open Order) Total sum</span>
                  <span class="label-1">150.00000000 BTC</span>
                </div>

              </b-col>
            </b-row>
            <div class="seperator m-b-sm" />
            <b-row align-v="center">
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-1">Daily withdrawal limit  </span>
                  <span class="label-1">150.00000000 BTC</span>
                </div>
              </b-col>
              <b-col sm="12" md="6" lg="6" xl="6" class="p-l-r">
                <div class="flex-space-between-vc m-b-sm">
                  <span class="label-4">On exchange (Open Order) Total sum</span>
                  <span class="label-4">150.00000000 BTC</span>
                </div>

              </b-col>
            </b-row>
          </div>
        </bit-crash-card>
      </div>
      <div class="w-h m-b">
        <bit-crash-card :body-style="1" :no-header="true">
          <div class="de-with-card-content">
            <b-row align-v="center">
              <b-col sm="12" md="6" lg="6" xl="6">
                <div class="flex-row-hl-vc">
                  <span class="label">BTC Price = $5735.00</span>
                </div>
              </b-col>
              <b-col sm="12" md="6" lg="6" xl="6">
                <div class="flex-row-hr-vc">
                  <deposit-btn type="deposit" style="margin-right: 15px;" />
                  <deposit-btn type="withdraw" />
                </div>
              </b-col>
            </b-row>
          </div>
        </bit-crash-card>
      </div>
      <div class="w-h m-b">
        <bit-crash-card :body-style="1" :no-header="true">
          <div class="qr-card-content">
            <b-row align-v="center">
              <b-col sm="12" md="3" lg="3" xl="3">
                <div class="flex-row-hc-vc m-b-sm">
                  <img src="@/assets/img/ic_qr_code.png">
                </div>
              </b-col>
              <b-col sm="0" md="1" lg="1" xl="1" class="seperator-1">
                <div class="flex-row-hc-vc">
                  <div style="width: 1px;height: 70px;background-color: #485992;" />
                </div>
              </b-col>
              <b-col sm="12" md="8" lg="8" xl="8">
                <div>
                  <div class="label m-b-sm">
                    Please use the following bitcoin address or scan OR
                    <br>
                    code to complete your transaction:
                  </div>
                  <chat-input-box text="Copy Address" class="m-b-sm" />
                  <div class="label-1 flex-row-hr-vc">
                    $1 = 1500 Taro Coins
                  </div>
                </div>
              </b-col>
            </b-row>
          </div>
        </bit-crash-card>
      </div>
    </b-row>
    <menu-bar @showOrHide="menuShowed" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import DepositBtn from '@/components/deposit/DepositBtn.vue'
// import { getNumberFormat, getFloat2Decimal } from '@/utils'
import PayBtn from '@/components/deposit/PayBtn'
import ChatInputBox from '@/components/chat/ChatInputBox'
import MenuBar from '@/components/deposit/Menu'

export default {
  name: 'Home',
  components: {
    BitCrashCard,
    PayBtn,
    DepositBtn,
    ChatInputBox,
    MenuBar
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
    ]),
    pay_types: {
      get() {
        return ['skins', 'bitcoin', 'alipay', 'wechat']
      }
    }
  },
  data() {
    return {
      menu: true
    }
  },
  created: function() {
  },
  methods: {
    payClick(type) {
    },
    menuShowed(show) {
      this.menu = show
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.root {
  position: relative;
  width: 100%;
}
.content-padding {
  padding-left: 50px;
  padding-top: 50px;
  padding-right: calc(50px + #{$chat-width} + #{$scrollbar-width});
  @include media-breakpoint-down(md) {
    padding-right: 50px;
  }
  padding-bottom: 50px;
}
.with-menu {
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
  padding-top: $deposit-bitcoin-card-padding-top-bottom;
  padding-bottom: $deposit-bitcoin-card-padding-top-bottom;
}
.bitcoin-content-logo {
  width: 100%;
  .label {
    font-size: $control-label-text-size;
    font-weight: bold;
    color: white;
    margin-left: 8px;
  }
}
.bitcoin-content {
  .label {
    font-size: $control-label-text-size-md;
    font-weight: bold;
    color: $navbar-text-color;
  }
  .label-high {
    color: $deposit-highlight-color;
  }
}
.price-content {
  .label {
    font-size: $control-label-text-size-md;
    font-weight: bold;
    color: $navbar-text-color;
  }
  .label-high {
    color: white;
  }
}
.bitcoin-lbl-card-content {
  padding-left: $deposit-card-padding-left-right;
  padding-right: $deposit-card-padding-left-right;
  padding-top: $deposit-bitcoin-lbl-card-padding-top-bottom;
  padding-bottom: $deposit-bitcoin-lbl-card-padding-top-bottom;
}
.btc-content {
  .p-l-r {
    padding-left: $gutter-width-wide;
    padding-right: $gutter-width-wide;
  }
  .label-1 {
    font-size: $control-label-text-size;
    color: white;
    font-weight: bold;
  }
  .label-2 {
    font-size: $control-label-text-size-sm;
    color: $navbar-text-color;
    font-weight: bold;
  }
  .label-3 {
    font-size: $control-label-text-size-sm;
    color: white;
  }
  .label-4 {
    font-size: $control-label-text-size-md;
    color: $deposit-highlight-color;
    font-weight: bold;
  }
}
.bitcoin-tbl-card-content {
  padding-left: $deposit-card-padding-left-right;
  padding-right: $deposit-card-padding-left-right;
  padding-top: $deposit-bitcoin-tbl-card-padding-top-bottom;
  padding-bottom: $deposit-bitcoin-tbl-card-padding-top-bottom;
}
.seperator {
  height: 1px;
  width: 100%;
  background-color: $user-tbl-header-border-color;
}
.de-with-card-content {
  padding-left: $deposit-card-padding-left-right;
  padding-right: $deposit-card-padding-left-right;
  padding-top: $deposit-de-with-card-padding-top-bottom;
  padding-bottom: $deposit-de-with-card-padding-top-bottom;
  .label {
    font-size: $control-label-text-size-md;
    color: $deposit-highlight-color;
    font-weight: bold;
  }
}
.qr-card-content {
  padding-left: $deposit-qr-card-padding-left-right;
  padding-right: $deposit-qr-card-padding-left-right;
  padding-top: $deposit-de-with-card-padding-top-bottom;
  padding-bottom: $deposit-de-with-card-padding-top-bottom;
  .label {
    font-size: $control-label-text-size-sm;
    font-weight: bold;
    color: white;
  }
  .label-1 {
    font-size: $control-label-text-size-sm;
    color: white;
  }
  .seperator-1 {
    @include media-breakpoint-down(md) {
      display: none;
    }
  }
}
</style>
