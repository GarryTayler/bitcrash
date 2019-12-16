<template>
  <div class="root content-padding">
    <div class="title-text">
      Frequently Asked Questions
    </div>
    <bit-crash-card :bodyStyle="1" :noHeader="true">
        <div class="card-content">
            <div v-for="item in faq" :key="item.id" class="m-b">
                <faq-section :data="item"></faq-section>
            </div>
        </div>
    </bit-crash-card>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import FaqSection from '@/components/faq/FaqSection.vue'
import { getList } from '@/api/faq'
// import { getNumberFormat, getFloat2Decimal } from '@/utils'

export default {
  name: 'Faq',
  components: {
    BitCrashCard,
    FaqSection
  },
  computed: {
    ...mapGetters([
      'is_logged_in',
      'wallet',
      'avatar',
      'crash_server_url',
      'user_id',
      'name',
      'token'
    ])
  },
  data() {
    return {
      faq: [
        {
            id: 0,
            title: 'Getting started with Bitcrash',
            items: [
            ]
        },
        {
            id: 1,
            title: 'Payment on Bitcrash',
            items: [
            ]
        }
      ],
      typeOptions: [{
        key: 0,
        displayName: 'Getting started with Bitcrash'
      }, {
        key: 1,
        displayName: 'Payment on Bitcrash'
      }],
      listQuery: {
        search_key: '',
        page: 1,
        limit: 10000,
        type: -1
      },
    }
  },
  methods: {
    faqListIndex(type) {
      var i = 0
      var isExist = false
      for (i = 0; i < this.faq.length; i++) {
        if(this.faq[i].id == type) {
          isExist = true
          break
        }
      }
      return i
    }
  },
  created: function() {
    this.faq[0].items = []
    this.faq[1].items = []
    getList(this.listQuery).then(response => {
      for (var i = 0; i < response.data.items.length; i++) {
        var index = this.faqListIndex(parseInt(response.data.items[i].type))
        var obj = response.data.items[i]
        obj["collapsed"] = true
        this.faq[index].items.push(obj)
      }
    })
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.root {
  position: relative;
  width: 100%;
}
.content-padding {
  padding-left: 50px;
  padding-top: 50px;
  padding-right: calc(50px + #{$chat-width} + #{$scrollbar-width});
  @include media-breakpoint-down(md) {
    padding-right: 50px;
  }
  padding-bottom: 50px;
}
.m-b {
  margin-bottom: $normal-margin-bottom-lg;
}
.m-b-sm {
  margin-bottom: $normal-margin-bottom-sm;
}
.m-l {
  margin-left: 15px;
}
.w-h {
    width: 100%;
}
.card-content {
  padding-left: 35px;
  padding-right: 35px;
  padding-top: 55px;
  padding-bottom: 55px;
}
.title-text {
  font-size: 21px;
  font-weight: bold;
  color: white;
  padding-top: 10px;
  padding-bottom: 10px;
}
</style>
