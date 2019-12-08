<template>
  <b-modal
          centered
          hide-footer
          id="signup-form"
           modal-class="login-signup-form"
           header-class="border-bottom-0">

    <h2>SignUp</h2>

    <form>
        <b-form-group label="UserName" label-for="form-username">
            <b-form-input id="form-username" v-model="form.username" placeholder="Your name here"></b-form-input>
        </b-form-group>
        <b-form-group label="Email" label-for="form-email">
            <b-form-input id="form-email" v-model="form.email" type="email" placeholder="Your email here"></b-form-input>
        </b-form-group>
        <b-form-group label="Password" label-for="form-password">
            <b-form-input id="form-password" v-model="form.password" type="password" placeholder="Your password here"></b-form-input>
        </b-form-group>
        <b-form-group label="Password Confirm" label-for="form-password-confirm">
          <b-form-input id="form-password-confirm" v-model="form.password_confirm" type="password" placeholder="Type your password again"></b-form-input>
        </b-form-group>
        <b-form-checkbox-group class="form-group">
          <b-form-checkbox id="form-agree" v-model="form.agree">I agree to the terms of service</b-form-checkbox>
        </b-form-checkbox-group>
        <log-in-button text="SignUp" @click="onSignup"></log-in-button>
    </form>
  </b-modal>
</template>

<script>
// import ContactButton from '@/components/ContactButton.vue';
import LogInButton from '@/components/navbar/LogInButton'
import { signup } from '@/api/user'

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
    isValid() {
      if (this.form.username === undefined || this.form.username == null || this.form.username.length <= 0) {
        return false
      }
      if (this.form.email === undefined || this.form.email == null || this.form.email.length <= 0) {
        return false
      }
      if (this.form.password === undefined || this.form.password == null || this.form.password.length <= 0) {
        return false
      }
      if (this.form.password_confirm === undefined || this.form.password_confirm == null || this.form.password_confirm.length <= 0) {
        return false
      }
      if (this.form.password_confirm !== this.form.password) {
        return false
      }
      if (this.form.agree === undefined || this.form.agree == null || this.form.agree === false) {
        return false
      }
      return true
    },
    onSignup() {
      // console.log('api has not been implemented yet.', this.form)
      var valid = this.isValid()
      if (valid) {
        this.loading = true
        var data = {
          username: this.form.username,
          email: this.form.email,
          password: this.form.password
        }
        signup(data).then(response => {
          if (response.code !== 20000) {
            // Error
          } else {
            console.log(response.data)
            this.$store
              .dispatch('user/login', { token: response.data.token })
              .then(() => {
                // this.$router.push({ path: this.redirect || '/', query: this.otherQuery })
                this.$store.dispatch('user/getInfo', this.token)
                this.$bvModal.hide('signup-form')
              })
              .catch(() => {
              })
          }
        })
      } else {
        console.log('error submit!!')
        return false
      }
    }
  }
}
</script>
