<template>
  <b-navbar toggleable="xl" type="dark" variant="dark" sticky class="">
    <b-navbar-brand href="/">
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
          <b-nav-item href="/#/withdraw" :class="{'link-active': isWithdrawActive}">
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
          <b-nav-item href="/#/fairness" :class="{'link-active': isFairnessActive}">
            <img src="@/assets/img/ic_referral.png" class="mr-sm">
            Provably Fair
          </b-nav-item>
        </b-navbar-nav>
        <div class="profile-bar-wrapper flex-row-hl-vc navbar-nav">
          <b-nav-item href="https://www.youtube.com/channel/UCXNUMvlp0iZ-VAIdHwkTvDg" target="new" style="margin-right: 1rem;">
            <img src="@/assets/img/iconfinder_lifesaver2_51567.png" class="mr-sm video-guide">
            Help Videos
          </b-nav-item>
          <profile-select v-if="token!=undefined && token!=''" :avatar-bits="wallet" :avatar-name="name" :avatar-image="avatar" />
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
    isWithdrawActive: {
      get() {
        return this.$route.path === '/withdraw'
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
    },
    isFairnessActive: {
      get() {
        return this.$route.path === '/fairness'
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
.profile-bar-wrapper {
  float: right;
  .login {
  }
  .signup {
  }
  .video-guide {
    width: 40px;
    height: 40px;
  }
}
.navbar-collapse.collapse.show .navbar-nav-wrapper .profile-bar-wrapper.navbar-nav {
    border: none;
    .nav-item {
      height: 57px;
    }
}

@media (min-width: 1200px)
{
  #nav-collapse {
    margin-left: 1rem;
  }
}

</style>
