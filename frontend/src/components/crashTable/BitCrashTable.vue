<template>
  <div class="bit-crash-table-wrapper">
    <table class="bit-crash-table">
      <thead>
        <th v-for="element in fields" :key="element.id">
          {{ element.label }}
        </th>
      </thead>
      <tbody>
        <tr v-if="items.length <= 0">
          <td colspan="20" style="text-align: center;line-height: 40px;">Empty</td>
        </tr>
        <tr v-for="item in items" :key="item.name" :class="{'active-background':item.name===name}">
          <td v-for="field in fields" :key="field.id">
            <user-profile v-if="field.type == 'profile'" :user="item[field.key]" :avatar="item.avatar" />
            <coin-label v-if="field.type=='bet'" :bet="setNumberFormat(item[field.key])" />
            <div v-if="field.type==='text' && field.key!=='bet' && field.key!=='profit'">
              {{ item[field.key] }}
            </div>
            <div v-if="field.type==='text' && (field.key==='bet' || field.key==='profit')">
              {{ setNumberFormat(item[field.key]) }}
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import CoinLabel from '@/components/crashTable/CoinLabel.vue'
import UserProfile from '@/components/crashTable/UserProfile.vue'
import { getNumberFormat } from '@/utils/index'
import { mapGetters } from 'vuex'

export default {
  name: 'BitCrashCard',
  components: {
    CoinLabel,
    UserProfile
  },
  props: {
    fields: {
      type: Array,
      default: function() {
        return []
      }
    },
    items: {
      type: Array,
      default: function() {
        return []
      }
    }
  },
  data() {
    return {
      striped: true
    }
  },
  computed: {
    ...mapGetters([
      'is_logged_in',
      'chat_server_url',
      'user_id',
      'name',
      'ipaddress',
      'token',
      'crash_chat',
      'avatar'
    ])
  },
  methods: {
    setNumberFormat(num) {
      return getNumberFormat(num)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.bit-crash-table-wrapper {
  display: block;
  width: 100%;
  overflow: auto;
  height: 100%;
  .bit-crash-table {
    font-size: $user-tbl-header-text-size;
    width: 100%;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;

    thead {
      font-weight: bold;
      color: white;
      border-bottom: 1px solid $user-tbl-header-border-color;

      th {
        padding-bottom: 20px;
        padding-left: 0.9vw;
        @include media-breakpoint-down(sm) {
          padding-left: 15px;
        }
      }
    }

    tbody {
      color: white;
      td {

        padding: 0.5vw;
        padding-left: 0.9vw;

        @include media-breakpoint-down(sm) {
          padding: 10px;
          padding-left: 15px;
        }

        img {
          width: $user-tbl-profile-size;
          border-radius: $navbar-profile-border-radius;
        }
      }
      .active-background {
        background-color: #17a2b8 !important;
      }
      tr:nth-child(even) {
        background-color: #485992;
      }
    }
  }
  .p-r-15 {
    padding-right: 15px;
    padding-left: 5px;
  }
}
</style>
