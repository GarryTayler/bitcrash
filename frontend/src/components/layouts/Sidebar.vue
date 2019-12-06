<template>
  <div class="sidebar">
    <ul>
      <li>
        <a
          :class="about"
          href="#"
          @click.prevent="scrollTo('section-about')"
        >WHO ARE WE</a>
      </li>
      <li>
        <a
          :class="together"
          href="#"
          @click.prevent="scrollTo('section-together')"
        >WORKING WITH US</a>
      </li>
      <li>
        <a
          :class="industry"
          href="#"
          @click.prevent="scrollTo('section-industry')"
        >INDUSTRY PARTNERS</a>
      </li>
    </ul>
  </div>
</template>

<script>
import navigation from '@/mixins/navigation'

export default {
  mixins: [navigation],
  props: ['section'],
  computed: {
    about() {
      if (this.section === 'about') return 'text-warning'
      return ''
    },
    together() {
      if (this.section === 'together') return 'text-warning'
      return ''
    },
    industry() {
      if (this.section === 'industry') return 'text-warning'
      return ''
    }
  }
}
</script>
