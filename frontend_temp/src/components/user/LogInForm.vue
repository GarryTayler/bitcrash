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
import global from '@/mixins/global'
import message from '@/filters/message.js'
export default {
  components: {
    LogInButton
  },
  mixins: [global],
  data() {
    return {
      form: {}
    }
  },
  methods: {
    onLogIn() {
      var valid = true
      if (valid) {
        const loader = this.showOverlay(null)
        this.loading = true
        this.form['token'] = ''
        this.$store
          .dispatch('user/login', this.form)
          .then((response) => {
            if (response.code === 20000) {
              this.$store.dispatch('user/getInfo', this.token)
              this.loading = false
              this.$bvModal.hide('login-form')
              this.$toast.success({
                title: 'Login Success',
                message: message.login_success_msg,
                position: 'top right',
                type: 'success',
                progressBar: true,
                color: '#51A351',
                showDuration: 4000,
                hideDuration: 6000
              })
            } else {
              this.$toast.error({
                title: 'Login Failed',
                message: response.message,
                position: 'top right',
                type: 'error',
                progressBar: true,
                color: '#BE2739',
                showDuration: 4000,
                hideDuration: 6000
              })
            }
            this.hideOverlay(loader)
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
            // loader.hide()
            this.hideOverlay(loader)
            this.loading = false
          })
      } else {
        return false
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>

