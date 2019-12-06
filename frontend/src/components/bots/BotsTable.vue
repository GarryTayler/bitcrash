<template>
  <div>
    <bit-crash-card>
        <div slot="header" class="card-header flex-space-between-vc" :class="type == 0 ? 'progress-user' : 'cashout-user'">
            <span>
              {{items.length}} {{type==0? 'in Game' : 'Cashed out'}}
            </span>
            <coin-label :bet="sum"></coin-label>
        </div>
        <div class="card-content">
            <bit-crash-table :fields="fields" :items="items"></bit-crash-table>
        </div>
    </bit-crash-card>
  </div>
</template>

<script>
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import BitCrashTable from '@/components/crashTable/BitCrashTable.vue'
import CoinLabel from '@/components/crashTable/CoinLabel.vue'
import { getFloat2Decimal } from '@/utils/index'

export default {
  name: 'BotsTable',
  props: {
    type: {
      type: Number,
      default: 0
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
    sum: function() {
      var sum = 0
      for (var i = 0; i < this.items.length; i += 1) {
        sum += this.items[i].bet * (this.type === 0 ? 1 : (this.items[i].option === undefined ? 1 : this.items[i].option / 100))
      }

      return getFloat2Decimal(sum)
    }
  },
  components: {
    BitCrashCard,
    BitCrashTable,
    CoinLabel
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
