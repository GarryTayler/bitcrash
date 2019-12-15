<template>
  <b-modal
    id="login-form"
    centered
    hide-footer
    modal-class="login-signup-form"
    header-class="border-bottom-0"
  >

    <h2>LogIn</h2>

    <form ref="loginForm">
      <b-form-group label="UserName / Email" label-for="form-username-email">
        <b-form-input id="form-username-email" v-model="form.username_email" placeholder="Your name or email here" />
      </b-form-group>
      <b-form-group label="Password" label-for="form-password">
        <b-form-input id="form-password" v-model="form.password" type="password" placeholder="Your password here" />
      </b-form-group>
      <log-in-button text="LogIn" @click="onLogIn" />
    </form>
  </b-modal>
</template>

<script>
// import ContactButton from '@/components/ContactButton.vue'
import LogInButton from '@/components/navbar/LogInButton'

export default {
  components: {
    LogInButton
  },
  data() {
    return {
      form: {}
    }
  },
  methods: {
    onLogIn() {
      // console.log('api has not been implemented yet.', this.form)
      var valid = true
      if (valid) {
        const loader = this.$loading.show({
          container: null,
          canCancel: false,
          loader: 'bars',
          color: '#3f48cc'
        })
        this.loading = true
        this.form['token'] = ''
        this.$store
          .dispatch('user/login', this.form)
          .then(() => {
            // this.$router.push({ path: this.redirect || '/', query: this.otherQuery })
            this.$store.dispatch('user/getInfo', this.token)
            this.loading = false
            this.$bvModal.hide('login-form')
            this.$toast.error({
              title: 'Login Success',
              message: 'You just logged in successfully.',
              position: 'top right',
              type: 'error',
              progressBar: true,
              color: '#51A351',
              showDuration: 4000,
              hideDuration: 6000
            })
            loader.hide()
          })
          .catch((err) => {
            this.$toast.error({
              title: 'Login Failed',
              message: err,
              position: 'top right',
              type: 'error',
              progressBar: true,
              color: '#BE2739',
              showDuration: 4000,
              hideDuration: 6000
            })
            loader.hide()
            this.loading = false
          })
      } else {
        console.log('error submit!!')
        return false
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>

