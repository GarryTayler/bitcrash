@@ -0,0 +1,86 @@
<template>
  <div>
    <div class="flex-row-hl-vc" :class="{'m-b-sm': data.collapsed==false}">
      <div class="title-text">{{data.question}}</div>
      <button class="collapse-btn" :class="{'discollapsed': data.collapsed==false}" @click="data.collapsed=!data.collapsed">
        <font-awesome-icon icon="plus" v-if="data.collapsed"/>
        <font-awesome-icon icon="minus" v-if="!data.collapsed"/>
      </button>
    </div>
    <span class="content-text" v-if="data.collapsed == false">{{data.answer}}</span>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
// import { getNumberFormat, getFloat2Decimal } from '@/utils'

export default {
  name: 'FaqItem',
  components: {
  },
  props: {
    data: {
      type: Object,
      default: function() {
        return {
        //   question: '',
        //   answer: '',
        //   collapsed: true
        }
      }
    }
  },
  computed: {
  },
  data() {
    return {
    }
  },
  methods: {
  },
  created: function() {
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.m-b-sm {
  margin-bottom: $normal-margin-bottom-sm;
}
.title-text {
  font-size: 18px;
  font-weight: bold;
  color: white;
  width: 100%;
}
.content-text {
  font-size: 14px;
  color: $navbar-text-color;
}
.collapse-btn {
  border: none;
  outline: none;
  width: 33px;
  height: 33px;
  background: transparent;
  border-radius: 0px;
  color: white;
  font-size: 16px;
  font-weight: bold;
  float: right;
  &:hover {
    background: rgba(0, 0, 0, 0.2)
  }
}
.discollapsed {
  background: #fec70d;
  border-radius: 50%;
  color: black;
  &:hover {
    background: #c99d0a;
  }
}
</style>
