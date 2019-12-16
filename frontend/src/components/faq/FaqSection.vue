@@ -0,0 +1,76 @@
<template>
  <div>
    <el-row>
      <el-col :xs="24" :sm="24" :md="8" :lg="8" class="m-b-sm">
        <span class="title-text">{{data.title}}</span>
      </el-col>
      <el-col :xs="24" :sm="24" :md="16" :lg="16">
        <div v-for="item in data.items" :key="item.id" class="content">
          <faq-item :data="item"></faq-item>
          <div class="seperator"></div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import FaqItem from './FaqItem.vue'
// import { getNumberFormat, getFloat2Decimal } from '@/utils'

export default {
  name: 'FaqSection',
  components: {
    FaqItem
  },
  props: {
    data: {
      type: Object,
      default: function() {
        return {
          title: '',
          items: []
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
  font-size: 22px;
  font-weight: bold;
  color: white;
}
.seperator {
  height: 1px;
  background-color: $user-tbl-header-border-color;
  width: 100%;
  margin-top: 25px;
  margin-bottom: 25px;
}
.content {
  &:last-child {
    .seperator {
      display: none;
    }
  }
}
</style>
