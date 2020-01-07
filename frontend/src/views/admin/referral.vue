<template>
  <div class="admin-page">
    <div class="filter-container">
      <div class="referral-label">Referral bonus(%)</div>
      <el-input v-model="referral_value" placeholder="Referral bonus(%)" style="width: 200px;" />
      <el-button class="m-l" type="primary" @click="changeFunc">
        Change
      </el-button>
    </div>
  </div>
</template>

<script>
import global from '@/mixins/global'
import { getReferralValue, updateReferralValue } from '@/api/user'
export default {
  components: {
  },
  filters: {
    statusFilter(status) {
      const statusMap = ['success', 'danger', 'info']
      return statusMap[status]
    },
    statusTextFilter(status) {
      const statusTextMap = ['active', 'stop', 'block']
      return statusTextMap[status]
    }
  },
  mixins: [global],
  props: {},
  data() {
    return {
      listLoading: true,
      referral_value: 0
    }
  },
  created() {
    this.getReferral()
  },
  methods: {
    getReferral() {
      getReferralValue({}).then(response => {
        this.referral_value = response.data.referral_value
      })
    },
    changeFunc() {
      const loader = this.showOverlay(null)
      // updateReferralValue
      updateReferralValue({ referral_value: this.referral_value }).then(response => {
        if (response.status === 'success') {
          this.showToast('Success', 'Referral bonus value is changed successfully.', 'success')
          this.hideOverlay(loader)
        } else {
          this.showToast('Error', 'Failed to change referral bonus value.', 'error')
          this.hideOverlay(loader)
        }
      }).catch(() => {
        this.showToast('Error', 'Network connection error.', 'error')
        this.hideOverlay(loader)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/admin_variables.scss";
.admin-page {
    padding: $page-padding;
}
.m-l {
    margin-left: $page-margin-left;
}
.m-t {
    margin-top: $page-margin-top;
}
.filter-container {
  align-items: center;
  display: flex;
  .referral-label {
    color: #000;
    margin-right: 15px;
  }
}
</style>
