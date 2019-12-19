<template>
  <b-navbar toggleable="lg" type="dark" variant="dark" sticky class="">
    <b-navbar-brand>
      <img src="@/assets/img/brand_logo.png" class="logo mr-sm-3">
      <img src="@/assets/img/brand_text.png" class="text">
    </b-navbar-brand>

    <div class="vert-seperator" />
    <b-navbar-toggle target="nav-collapse">
      <span class="icon-bar" />
      <span class="icon-bar" />
      <span class="icon-bar" />
    </b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <div class="navbar-nav-wrapper">
        <b-navbar-nav>
          <b-nav-item href="/#/home" :class="{'link-active': isHomeActive}">
            <img src="@/assets/img/ic_bits2usd.png" class="mr-sm">
            Crash
          </b-nav-item>
          <b-nav-item href="/#/deposit" :class="{'link-active': isDepositActive}">
            <img src="@/assets/img/ic_leaderboard.png" class="mr-sm">
            Deposit
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_bitcoin.png" class="mr-sm">
            Withdraw
          </b-nav-item>
          <b-nav-item href="/#/faq" :class="{'link-active': isFaqActive}">
            <img src="@/assets/img/ic_faq.png" class="mr-sm">
            FAQ
          </b-nav-item>
          <b-nav-item href="/#/referral" :class="{'link-active': isReferralActive}">
            <img src="@/assets/img/ic_referral.png" class="mr-sm">
            Referral
          </b-nav-item>
          <b-nav-item>
            <img src="@/assets/img/ic_referral.png" class="mr-sm">
            Provably Fair
          </b-nav-item>
        </b-navbar-nav>
        <div class="profile-bar-wrapper flex-row-hl-vc">
          <profile-select v-if="token!=undefined && token!=''" :avatar-bits="wallet" :avatar-name="name" />
          <log-in-button v-if="token==undefined || token==''" text="LogIn" class="login" @click="logIn" />
          <log-in-button v-if="token==undefined || token==''" text="SignUp" class="signup" @click="signUp" />
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
  components: {
    ProfileSelect,
    LogInButton
  },
  mixins: [navigation],
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
    ]),
    isHomeActive: {
      get() {
        return this.$route.path === '/home'
      }
    },
    isDepositActive: {
      get() {
        return this.$route.path === '/deposit'
      }
    },
    isFaqActive: {
      get() {
        return this.$route.path === '/faq'
      }
    },
    isReferralActive: {
      get() {
        return this.$route.path === '/referral'
      }
    }
  },
  methods: {
    logIn() {
      this.$bvModal.show('login-form')
    },
    signUp() {
      this.$bvModal.show('signup-form')
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
