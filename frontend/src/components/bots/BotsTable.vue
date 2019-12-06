<template>
  <div>
    <bit-crash-card>
      <div slot="header" class="card-header flex-space-between-vc" :class="type == 0 ? 'progress-user' : 'cashout-user'">
        <span>
          {{ bots.length }} {{ type==0? 'in Game' : 'Cashed out' }}
        </span>
        <coin-label />
      </div>
      <div class="card-content">
        <bit-crash-table :fields="fields" :items="items" />
      </div>
    </bit-crash-card>
  </div>
</template>

<script>
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import BitCrashTable from '@/components/crashTable/BitCrashTable.vue'
import CoinLabel from '@/components/crashTable/CoinLabel.vue'

export default {
  name: 'BotsTable',
  components: {
    BitCrashCard,
    BitCrashTable,
    CoinLabel
  },
  props: {
    type: {
      type: Number,
      default: 0
    },
    bots: {
      type: Array,
      default() {
        return []
      }
    },
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
  computed: {
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";

.card-header {
  height: $card-header-height;
  padding-left: 30px;
  padding-right: 30px;
  padding-bottom: 20px;
  padding-top: 20px;

  color: white;
  font-size: 18px;
  font-weight: bold;
}
.card-content {
  padding: 20px;
}
.progress-user {
  background: linear-gradient(90deg, #04aef7, #1c8ace);
}
.cashout-user {
  background: linear-gradient(90deg, #20be82, #14a092);
}
</style>
