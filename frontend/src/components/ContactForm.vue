<template>
  <b-modal
    id="contact-form"
    centered
    hide-footer
    modal-class="contact-form"
    header-class="border-bottom-0 rounded-0"
    header-border-variant="dark"
    header-bg-variant="dark"
    body-bg-variant="dark"
  >

    <h2 class="text-warning">GET IN TOUCH</h2>

    <div class="contacts">
      <b-row v-for="contact in contacts" :key="contact.name" class="mb-3 mb-md-0">
        <b-col md="5" lg="4" xl="3">
          <label class="text-light">
            {{ contact.name }}
          </label>
        </b-col>
        <b-col md="7" lg="8" xl="9">
          <a v-if="contact.link" :href="contact.link" class="text-warning underline">
            {{ contact.value }}
          </a>
          <label v-if="!contact.link" class="text-warning">
            {{ contact.value }}
          </label>
        </b-col>
      </b-row>
    </div>

    <h2 class="text-warning">
      <span>SEND US </span>
      <span class="text-nowrap">A MESSAGE</span>
    </h2>

    <form @submit.prevent="onSubmit">
      <b-row>
        <b-col md="6">
          <b-form-group
            label="FIRST NAME"
            label-for="form-firstname"
          >
            <b-form-input
              id="form-firstname"
              v-model="form.firstname"
              placeholder="Your first name here"
            />
          </b-form-group>
        </b-col>
        <b-col md="6">
          <b-form-group
            label="LAST NAME"
            label-for="form-lastname"
          >
            <b-form-input
              id="form-lastname"
              v-model="form.lastname"
              placeholder="Your last name here"
            />
          </b-form-group>
        </b-col>
      </b-row>

      <b-row>
        <b-col md="6">
          <b-form-group
            label="TELEPHONE"
            label-for="form-telephone"
          >
            <b-form-input
              id="form-telephone"
              v-model="form.phone"
              placeholder="Your phone number here"
            />
          </b-form-group>
        </b-col>
        <b-col md="6">
          <b-form-group
            label="EMAIL"
            label-for="form-email"
          >
            <b-form-input
              id="form-email"
              v-model="form.email"
              placeholder="Your email here"
            />
          </b-form-group>
        </b-col>
      </b-row>

      <b-form-group
        label="MESSAGE"
        label-for="form-message"
      >
        <b-form-textarea
          id="form-message"
          v-model="form.message"
          rows="5"
          placeholder="Your message here..."
        />
      </b-form-group>
      <contact-button :submit="true" @submitted="onSubmit" />
    </form>
  </b-modal>
</template>

<script>
import ContactButton from '@/components/ContactButton.vue'

export default {
  components: {
    ContactButton
  },
  data: () => ({
    contacts: [
      { name: 'General Inquiries', value: 'info@honeytek.com', link: '#' },
      { name: 'Phone', value: '(416) 620-5535', link: '#' },
      { name: 'Address', value: '5535 Eglinton Ave W #220, Etobicoke, ON M9C 5K5', link: false }
    ],
    form: {}
  }),
  methods: {
    onSubmit() {
    }
  }
}
</script>
