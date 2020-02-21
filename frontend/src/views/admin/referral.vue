<template>
  <div class="admin-page">
    <div class="filter-container">
      <el-input v-model="listQuery.username" placeholder="User Name or Email" style="width: 200px;" @keyup.enter.native="handleFilter" />
      <el-button class="m-l" type="primary" @click="handleFilter">
        Search
      </el-button>
    </div>
    <el-table v-loading="listLoading" class="m-t" :data="list" border fit highlight-current-row style="width: 100%">

      <el-table-column align="center" label="Id" width="80">
        <template slot-scope="scope">
          <span>{{ scope.row.ID }}</span>
        </template>
      </el-table-column>

      <el-table-column width="200px" align="center" label="Username">
        <template slot-scope="scope">
          <img :src="scope.row.AVATAR" alt="Avatar" width="40px" height="40px" style="border-radius: 4px; margin-right: 5px;">
          <span>{{ scope.row.USERNAME }}</span>
        </template>
      </el-table-column>

      <el-table-column width="240px" align="center" label="Email">
        <template slot-scope="scope">
          <span>{{ scope.row.EMAIL }}</span>
        </template>
      </el-table-column>

      <el-table-column width="80px" align="center" label="Bonus">
        <template slot-scope="scope">
          <span>{{ scope.row.FEE }}%</span>
        </template>
      </el-table-column>

      <el-table-column width="80px" align="center" label="Profit">
        <template slot-scope="scope">
          <span>{{ scope.row.AMOUNT_COINS }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="Log Date">
        <template slot-scope="scope">
          <span>{{ scope.row.CREATE_TIME | parseTime('{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column width="150px" align="center" label="Referral Code">
        <template slot-scope="scope">
          <span>{{ scope.row.REFERRAL_CODE }}</span>
        </template>
      </el-table-column>
      <el-table-column width="150px" align="center" label="Referral Username">
        <template slot-scope="scope">
          <span>{{ scope.row.REF_USERNAME }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="Referral Email">
        <template slot-scope="scope">
          <span>{{ scope.row.REF_EMAIL }}</span>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />
  </div>
</template>

<script>
import { getReferralList } from '@/api/bitcoin'
import Pagination from '@/components/Pagination' // Secondary package based on el-pagination
import global from '@/mixins/global'
export default {
  components: {
    Pagination
  },
  mixins: [global],
  props: {},
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        username: '',
        page: 1,
        limit: 20
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      /* fetchList(this.listQuery).then(response => {
        this.list = response.data.items
        this.total = response.data.total
        this.listLoading = false
      }) */
      getReferralList(this.listQuery).then(response => {
        this.list = response.data.items
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
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
</style>
