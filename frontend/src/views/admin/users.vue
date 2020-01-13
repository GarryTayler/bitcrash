<template>
  <div class="admin-page">
    <div class="filter-container">
      <el-input v-model="listQuery.search_key" placeholder="Name" style="width: 200px;" @keyup.enter.native="handleFilter" />
      <el-button class="m-l" type="primary" @click="handleFilter">
        Search
      </el-button>
    </div>
    <el-table v-loading="listLoading" class="m-t" :data="list" border fit highlight-current-row style="width: 100%">

      <el-table-column align="center" label="ID" width="80">
        <template slot-scope="scope">
          <span>{{ scope.row.ID }}</span>
        </template>
      </el-table-column>

      <el-table-column width="80px" align="center" label="Avatar">
        <template>
          <img src="@/assets/img/avatar-sample.png" alt="Avatar" width="40px" height="40px">
          <!-- <span>{{ scope.row.AVATAR }}</span> -->
        </template>
      </el-table-column>

      <el-table-column width="110px" align="center" label="Username">
        <template slot-scope="scope">
          <span>{{ scope.row.USERNAME }}</span>
        </template>
      </el-table-column>

      <el-table-column width="130px" align="center" label="Email">
        <template slot-scope="scope">
          <span>{{ scope.row.EMAIL }}</span>
        </template>
      </el-table-column>

      <el-table-column width="80px" align="center" label="Wallet">
        <template slot-scope="scope">
          <span>{{ scope.row.WALLET }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="Registeration Date">
        <template slot-scope="scope">
          <span>{{ scope.row.CREATE_TIME | parseTime('{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>

      <el-table-column width="80px" align="center" label="Last Visit">
        <template slot-scope="scope">
          <span>{{ scope.row.last_visit | parseTime('{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>

      <el-table-column width="70px" align="center" label="IP Address">
        <template slot-scope="scope">
          <span>{{ scope.row.IPADDRESS }}</span>
        </template>
      </el-table-column>

      <el-table-column width="100px" align="center" label="Status">
        <template slot-scope="scope">
          <el-tag :type="scope.row.STATE | statusFilter">
            {{ scope.row.STATE | statusTextFilter }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column align="left" label="Actions">
        <template slot-scope="{row}">
          <el-button type="danger" size="small" @click="handleDel(row)">
            Delete
          </el-button>

          <el-button v-if="row.STATE == 0" type="primary" size="small" @click="handleBlock(row)">
            Block
          </el-button>

          <el-button v-if="row.STATE == 2" type="info" size="small" @click="handleActivate(row)">
            Activate
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />
  </div>
</template>

<script>
import { fetchList, updateUser } from '@/api/user'
import Pagination from '@/components/Pagination' // Secondary package based on el-pagination
export default {
  components: {
    Pagination
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
  props: {},
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        search_key: '',
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
      fetchList(this.listQuery).then(response => {
        this.list = response.data.items
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    handleDel(row) {
      updateUser({ id: row.ID, del_yn: 'Y' }).then(response => {
        this.getList()
      })
    },
    handleBlock(row) {
      updateUser({ id: row.ID, state: 2 }).then(response => {
        this.getList()
      })
    },
    handleActivate(row) {
      updateUser({ id: row.ID, state: 0 }).then(response => {
        this.getList()
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
</style>
