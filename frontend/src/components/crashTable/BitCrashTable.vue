<template>
  <div class="bit-crash-table-wrapper">
    <table class="bit-crash-table">
      <thead>
        <th v-for="element in fields" :key="element.id">
          {{ element.label }}
        </th>
      </thead>
      <tbody>
        <tr v-for="item in items" :key="item.id">
          <td v-for="field in fields" :key="field.id">
            <user-profile v-if="field.type == 'profile'" :user="item[field.key]" />
            <coin-label v-if="field.type=='bet'" :bet="item[field.key]" />
            <div v-if="field.type=='text'">
              {{ item[field.key] }}
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
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
.bit-crash-table-wrapper {
  // padding-left: 40px;
  // padding-right: 10px;
  display: block;
  width: 100%;

  .bit-crash-table {
    font-size: $user-tbl-header-text-size;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;

    thead {
      font-weight: bold;
      color: white;
      border-bottom: 1px solid $user-tbl-header-border-color;

      th {
        padding-bottom: 20px;
      }
    }

    tbody {
      color: white;

      td {
        padding: 10px;
        padding-left: 15px;

        img {
          width: $user-tbl-profile-size;
          border-radius: $navbar-profile-border-radius;
        }
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
