<template>
  <div>
    <div class="flex-row root">
      <b-row align-v="start" class="flex-space-between-vc content-padding main-content">
        <div>
          <h3>Referral</h3>
          <span class="description">Invite your friends and earn money</span>
        </div>
        <b-row class="ml-1 top-bar" />
        <b-row class="ml-1 top-content m-b">
          <b-col sm="12" md="6" lg="4" xl="4" class="manual">
            <img src="@/assets/img/referral_1.png">
            <div class="p-15">
              <span>1</span><br>
              <span>Share your referral link or code</span><br>
              <span class="description">Everyone who registers through your link or uses your code becomes your referral. The Code will give your referrals + 5% on their first deposit.</span>
            </div>
          </b-col>
          <b-col sm="12" md="6" lg="4" xl="4" class="manual">
            <img src="@/assets/img/referral_2.png">
            <div class="p-15">
              <span>2</span><br>
              <span>Earn Money and Rank Points</span><br>
              <span class="description">You will get up to 40% of our revenue(House Edge) from bets placed by your referrals and Rank Points equal to their first deposit.</span>
            </div>
          </b-col>
          <b-col sm="12" md="6" lg="4" xl="4" class="manual">
            <img src="@/assets/img/referral_3.png">
            <div class="p-15">
              <span>3</span><br>
              <span>Use earned money for betting or withdrawal</span><br>
              <span class="description">Simple, isn't it? if you need any help, contact our support.</span>
            </div>
          </b-col>
        </b-row>
        <b-row class="w-100 m-b">
          <b-col sm="12" md="12" lg="12" xl="12">
            <bit-crash-card :body-style="1" :no-header="true" class="link-content">
              <b-row>
                <b-col sm="12" md="6" lg="6" xl="6">
                  <div class="card-content">
                    <span style="margin: 20px;">
                      You referral link
                    </span><br>
                    <div class="bg flex-space-between-vc" style="margin-top: 10px">
                      <input
                        class="text"
                        @focus="handleFocus"
                        @blur="handleBlur"
                        @input="handleInput"
                      >
                      <crash-button text="Copy" @click="handleBlur" />
                    </div>
                  </div>
                </b-col>
                <b-col sm="12" md="6" lg="6" xl="6">
                  <div class="card-content">
                    <span>
                      You referral code
                    </span><br>
                    <div class="bg flex-space-between-vc" style="margin-left: -10px; margin-top: 10px">
                      <input
                        v-model="currentValue"
                        class="text"
                        @focus="handleFocus"
                        @blur="handleBlur"
                        @input="handleInput"
                      >
                      <crash-button text="Change" :disabled="true" />
                    </div>
                    <br>
                    <span class="description">
                      New users will get +5% bonus on their first deposit for using your code.
                    </span>
                  </div>
                </b-col>
              </b-row>
            </bit-crash-card>
          </b-col>
        </b-row>
        <b-row class="w-100" cl>
          <b-col sm="12" md="5" lg="5" xl="5" class="m-b">
            <bit-crash-card :body-style="1" :no-header="true" class="link-content">
              <b-row>
                <b-col sm="12" md="12" lg="12" xl="12">
                  <div class="card-content">
                    <span style="margin: 20px;">
                      Your level silver (10%)
                    </span><br>
                    <level-silver class="mt-4" />
                  </div>
                </b-col>
              </b-row>
            </bit-crash-card>
          </b-col>
          <b-col sm="12" md="7" lg="7" xl="7" class="m-b">
            <bit-crash-card :body-style="1" :no-header="true" class="link-content h-100">
              <b-row>
                <b-col sm="12" md="12" lg="12" xl="12">
                  <div class="card-content">
                    <div>
                      <b-nav tabs fill>
                        <b-nav-item active>TODAY</b-nav-item>
                        <b-nav-item>7 DAYS</b-nav-item>
                        <b-nav-item>30 DAYS</b-nav-item>
                        <b-nav-item>ALL TIME</b-nav-item>
                      </b-nav>
                    </div>
                  </div>
                </b-col>
                <b-col sm="12" md="12" lg="12" xl="12">
                  <b-row align-h="between" class="text-center">
                    <b-col v-for="item in option_types" :key="item" sm="4" md="4" lg="4" xl="4" class="ml-md-auto p-3">
                      <wallet-sect :type="item" />
                    </b-col>
                  </b-row>
                </b-col>
              </b-row>
            </bit-crash-card>
          </b-col>
        </b-row>
        <b-row class="m-b ml-1 w-100">
          <b-col sm="12" md="9" lg="9" xl="9">
            <h4>Groups</h4>
          </b-col>
          <b-col sm="12" md="3" lg="3" xl="3">
            <div class="flex-row-hc-vc price-content">
              <span class="label-high">CREATE GROUP+</span>
            </div>
          </b-col>
        </b-row>
        <b-row class="m-b w-100">
          <b-col sm="12" md="12" lg="12" xl="12">
            <bit-crash-card :body-style="0" :no-header="false" class="link-content">
              <div slot="header" class="card-header flex-space-between-vc">
                <b-row class="w-100">
                  <b-col sm="6" md="3" lg="3" xl="3">
                    <span class="subtitle">
                      Name
                    </span><br>
                    <span>
                      REF_6879555
                    </span>
                  </b-col>
                  <b-col sm="6" md="3" lg="3" xl="3">
                    <span class="subtitle">
                      Url
                    </span><br>
                    <span>
                      ..dfew
                    </span>
                  </b-col>
                  <b-col sm="6" md="3" lg="3" xl="3">
                    <span class="subtitle">
                      Created
                    </span><br>
                    <span>
                      20-09-2019
                    </span>
                  </b-col>
                  <b-col sm="6" md="3" lg="3" xl="3">
                    <span class="subtitle">
                      Your income
                    </span><br>
                    <div class="flex-row-hl-vc">
                      <img src="@/assets/img/ic_bitcoin_col.png" width="25px">
                      <span class="label ml-2">0</span>
                    </div>
                  </b-col>
                </b-row>
              </div>
              <div class="card-content">
                <b-row align-h="center">
                  <b-col sm="12" md="6" lg="6" xl="6">
                    <span style="margin: 20px;">
                      You referral link
                    </span><br>
                    <div class="bg flex-space-between-vc" style="margin-top: 10px;margin-bottom: 10px">
                      <input
                        class="text"
                        @focus="handleFocus"
                        @blur="handleBlur"
                        @input="handleInput"
                      >
                      <crash-button text="Copy" @click="handleBlur" />
                    </div>
                    <span style="margin: 20px;">
                      You referral code
                    </span><br>
                    <div class="bg flex-space-between-vc" style="margin-top: 10px">
                      <input
                        class="text"
                        @focus="handleFocus"
                        @blur="handleBlur"
                        @input="handleInput"
                      >
                      <crash-button text="Change" :disabled="true" @click="handleBlur" />
                    </div>
                  </b-col>
                  <b-col sm="12" md="6" lg="6" xl="6">
                    <b-row align-h="between" class="text-center">
                      <b-col v-for="item in option_types" :key="item" sm="4" md="4" lg="4" xl="4" class="ml-md-auto p-3">
                        <wallet-sect :type="item" />
                      </b-col>
                    </b-row>
                  </b-col>
                </b-row>
              </div>
            </bit-crash-card>
          </b-col>
        </b-row>
        <b-row class="m-b w-100">
          <crash-button text="CREATE GROUP" :disabled="false" class="m-auto" />
        </b-row>
        <b-row class="m-b w-100">
          <b-col sm="12" md="12" lg="12" xl="12">
            <bit-crash-card :body-style="0" :no-header="false" class="link-content">
              <div slot="header" class="card-header flex-space-between-vc all-bets">
                <span>
                  Title
                </span>
              </div>
              <div class="card-content">
                <bit-crash-table :fields="title_tbl_fields" :items="title_tbl_items" />
              </div>
            </bit-crash-card>
          </b-col>
        </b-row>
        <b-row class="m-b w-100">
          <crash-button text="Get Banners" :disabled="false" class="m-auto" />
        </b-row>
      </b-row>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import CrashButton from '@/components/ui/CrashButton.vue'
import BitCrashTable from '@/components/crashTable/BitCrashTable.vue'
import LevelSilver from '@/components/referral/LevelSilver.vue'
import WalletSect from '@/components/referral/WalletSect.vue'

export default {
  name: 'Home',
  components: {
    BitCrashCard,
    CrashButton,
    BitCrashTable,
    LevelSilver,
    WalletSect
  },
  data() {
    return {
      currentValue: this.value,
      focus: false,
      title_tbl_fields: [
        {
          id: 1,
          label: 'Level',
          type: 'text',
          key: 'level'
        },
        {
          id: 2,
          label: 'Unique depositors(Active)',
          type: 'text',
          key: 'type'
        },
        {
          id: 3,
          label: '-or-',
          type: 'text',
          key: 'or'
        },
        {
          id: 4,
          label: 'Monthly win/loss',
          type: 'text',
          key: 'win'
        },
        {
          id: 5,
          label: 'Your Commision(of hours edge)',
          type: 'text',
          key: 'profit'
        }
      ],
      title_tbl_items: [
        {
          level: 'Silver', type: '0-100', or: '', win: '100k', profit: '10%'
        },
        {
          level: 'Silver', type: '0-100', or: '', win: '100k', profit: '10%'
        },
        {
          level: 'Silver', type: '0-100', or: '', win: '100k', profit: '10%'
        }
      ]
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
    ]),
    option_types: {
      get() {
        return ['user', 'bet', 'income']
      }
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
}
.main-content {
  width: 100%;
  color: #ffffff;

  .description {
    color: $navbar-profile-text-color;
  }

  .top-content {
    width: 100%;
    padding-top: 60px;
    background: -webkit-radial-gradient(circle, #28375e, #1e2843, #1e2843); /* Safari */
    background: -o-radial-gradient(circle, #28375e, #1e2843, #1e2843); /* Opera 11.6 to 12.0 */
    background: -moz-radial-gradient(circle, #28375e, #1e2843, #1e2843); /* Firefox 3.6 to 15 */
    background: radial-gradient(circle, #28375e, #1e2843, #1e2843); /* Standard syntax */
  }

  .top-bar {
    margin-top: 24px;
    height: 1px;
    width: 100%;
    background: -webkit-radial-gradient(circle, #3c4b7c, #1e2843, #1e2843); /* Safari */
    background: -o-radial-gradient(circle, #3c4b7c, #1e2843, #1e2843); /* Opera 11.6 to 12.0 */
    background: -moz-radial-gradient(circle, #3c4b7c, #1e2843, #1e2843); /* Firefox 3.6 to 15 */
    background: radial-gradient(circle, #3c4b7c, #1e2843, #1e2843); /* Standard syntax */
  }
  .subtitle {
    color: #c9d6e4;
  }
}
.card-content {
  padding: 35px;
  width: 100%;
}
.card-header {
  background: linear-gradient(90deg, #28335e, #28335e);
}
.content-padding {
  padding-left: 50px;
  padding-top: 50px;
  padding-right: calc(50px + #{$chat-width});
  padding-bottom: 50px;
  @include media-breakpoint-down(md) {
    padding-right: 50px;
    padding-left: 50px;
  }
}
.link-content {
  width: 100%;
}
.manual {
  text-align: center;
}
.p-15 {
  padding: 15px;
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

.nav-tabs .nav-link.active {
  color: white;
  background: transparent;
  border: none;
  border-bottom: 2px solid #62a0fe;
}

.nav-tabs .nav-link {
  color: white;
  border: none;
  border-bottom: 1px solid #485992;
  & :hover {
    border: none;
  }
}
.m-b {
  margin-bottom: $normal-margin-bottom-lg;
}
</style>
