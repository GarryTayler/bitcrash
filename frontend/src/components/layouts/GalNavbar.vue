<template>
  <b-navbar toggleable="lg" type="dark" variant="dark" sticky class="">
    <b-navbar-brand>
      <img src="@/assets/img/brand_logo.png" class="logo mr-sm-3" />
      <img src="@/assets/img/brand_text.png" class="text" />
    </b-navbar-brand>

    <div class="vert-seperator"></div>
    <b-navbar-toggle target="nav-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <div class="navbar-nav-wrapper">
        <b-navbar-nav>
          <b-nav-item>
            <img src="@/assets/img/ic_bits2usd.png" class="mr-sm" />
            Crash
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_leaderboard.png" class="mr-sm" />
            Deposit
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_bitcoin.png" class="mr-sm" />
            Withdraw
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_faq.png" class="mr-sm" />
            FAQ
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_referral.png" class="mr-sm" />
            REFERRAL
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_referral.png" class="mr-sm" />
            Provably Fair
          </b-nav-item>
        </b-navbar-nav>
        <div class="profile-bar-wrapper flex-row-hl-vc">
          <profile-select :avatar-bits="wallet" :avatar-name="name" v-if="token!=undefined && token!=''"></profile-select>
          <log-in-button text="LogIn" class="login" @click="logIn" v-if="token==undefined || token==''"></log-in-button>
          <log-in-button text="SignUp" class="signup" @click="signUp" v-if="token==undefined || token==''"></log-in-button>
        </div>
      </div>
    </b-collapse>
  </b-navbar>
</template>

<script>
import { mapGetters } from 'vuex'
import navigation from '@/mixins/navigation'
import ProfileSelect from '@/components/navbar/ProfileSelect'
import LogInButton from '@/components/navbar/LogInButton'

export default {
  mixins: [navigation],
  components: {
    ProfileSelect,
    LogInButton
  },
  data() {
    return {
      loginForm: {
        username: 'Test Account',
        email: 'test@test.com',
        password: '1111'
      },
      loading: false
    }
  },
  computed: {
    ...mapGetters([
      'token',
      'name',
      'wallet',
      'avatar'
    ])
  },
  methods: {
    logIn() {
      console.log('LogIn')
      // this.$refs.loginForm.validate(valid => {
      //   if (valid) {
      //     this.loading = true
      this.$store.dispatch('user/login', this.loginForm)
        .then(() => {
          // this.$router.push({ path: this.redirect || '/', query: this.otherQuery })
          this.$store.dispatch('user/getInfo', this.token)
          this.loading = false
        })
        .catch(() => {
          this.loading = false
        })
      //   } else {
      //     console.log('error submit!!')
      //     return false
      //   }
      // })
    },
    signUp() {
      console.log('Signup')
    }
  }
}
</script>
<style lang="scss" scoped>
// @import "~bootstrap/scss/bootstrap";
// @import "~bootstrap-vue/src/index";
.profile-bar-wrapper {
  float: right;
  .login {
  }
  .signup {
  }
}
</style>
