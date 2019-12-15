<template>
  <div class="admin-page">
    <div class="filter-container">

      <b-row>
        <b-col sm="12" md="8" lg="8" xl="8" class="pt-2 pb-2">
          <el-date-picker v-model="listQuery.start_date_obj" type="datetime" format="yyyy-MM-dd" placeholder="Please pick a date" class="mr-2" @change="handleFilter" />
          <el-date-picker v-model="listQuery.end_date_obj" type="datetime" format="yyyy-MM-dd" placeholder="Please pick a date" @change="handleFilter" />
        </b-col>
        <b-col sm="12" md="4" lg="4" xl="4" class="pt-2 pb-2">
          <el-button class="m-l" type="primary" style="float: right;" @click="handleFilter">
            Search
          </el-button>
        </b-col>
      </b-row>

    </div>
    <el-table v-loading="listLoading" :data="list" border fit highlight-current-row style="width: 100%">
      <el-table-column align="center" label="ID" width="80">
        <template slot-scope="scope">
          <span class="link-type" @click="showDetail(scope.row.ID)">{{ scope.row.ID }}</span>
        </template>
      </el-table-column>

      <el-table-column width="160px" align="center" label="Time">
        <template slot-scope="scope">
          <span class="link-type" @click="showDetail(scope.row.ID)">{{ scope.row.REGTIME | parseTime('{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="GameRound">
        <template slot-scope="scope">
          <span>{{ scope.row.GAMENO }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="BUST">
        <template slot-scope="scope">
          <span>{{ scope.row.BUST }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="Total">
        <template slot-scope="scope">
          <span>{{ scope.row.TOTAL }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="Profit">
        <template slot-scope="scope">
          <span>{{ scope.row.PROFIT }}</span>
        </template>
      </el-table-column>

      <el-table-column width="150px" align="center" label="Bots">
        <template slot-scope="scope">
          <span>{{ scope.row.BOTS }}</span>
        </template>
      </el-table-column>

      <el-table-column align="center" label="Hash">
        <template slot-scope="scope">
          <span>{{ scope.row.HASH }}</span>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />

    <el-dialog :visible.sync="dlgVisible" title="Detail">
      <table class="detail-table">
        <tr style="display: none">
          <th style="width: 100px;">Key</th>
          <th>Val</th>
        </tr>
        <tr>
          <td>Reg Time</td>
          <td>{{ dlgData.REGTIME | parseTime('{y}-{m}-{d} {h}:{i}') }}</td>
        </tr>
        <tr>
          <td>GameRound</td>
          <td>{{ dlgData.GAMENO }}</td>
        </tr>
        <tr>
          <td>Start Time</td>
          <td>{{ dlgData.STARTTIME | parseTime('{y}-{m}-{d} {h}:{i}') }}</td>
        </tr>
        <tr>
          <td>Busted Time</td>
          <td>{{ dlgData.BUSTEDTIME | parseTime('{y}-{m}-{d} {h}:{i}') }}</td>
        </tr>
        <tr>
          <td>Bust</td>
          <td>{{ dlgData.BUST }}</td>
        </tr>
        <tr>
          <td>Total</td>
          <td>{{ dlgData.TOTAL }}</td>
        </tr>
        <tr>
          <td>Profit</td>
          <td>{{ dlgData.PROFIT }}</td>
        </tr>
        <tr>
          <td>Users</td>
          <td>{{ dlgData.USERS }}</td>
        </tr>
        <tr>
          <td>Bots</td>
          <td>{{ dlgData.BOTS }}</td>
        </tr>
        <tr>
          <td>Hash</td>
          <td>{{ dlgData.HASH }}</td>
        </tr>
        <tr>
          <td>State</td>
          <td>{{ dlgData.STATE }}</td>
        </tr>
      </table>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dlgVisible = false">Confirm</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getHistoryList } from '@/api/crash'
import Pagination from '@/components/Pagination' // Secondary package based on el-pagination

export default {
  components: {
    Pagination
  },
  props: {},
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        start_date_obj: null,
        end_date_obj: null,
        start_date: null,
        end_date: null,
        page: 1,
        limit: 20
      },
      dlgData: {
        REGTIME: 0,
        GAMENO: 0,
        STARTTIME: 0,
        BUSTEDTIME: 0,
        BUST: 0,
        TOTAL: 0,
        PROFIT: 0,
        USERS: 0,
        BOTS: 0,
        HASH: 0,
        STATE: ''
      },
      dlgVisible: false
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      this.listQuery.start_date = this.listQuery.start_date_obj == null ? '' : this.listQuery.start_date_obj.toISOString().substr(0, 10)
      this.listQuery.end_date = this.listQuery.end_date_obj == null ? '' : this.listQuery.end_date_obj.toISOString().substr(0, 10)
      getHistoryList(this.listQuery).then(response => {
        this.list = response.data.items
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    startDatePick() {
    },
    endDatePick() {
    },
    showDetail(id) {
      getHistoryList({
        id: id,
        page: 1,
        limit: 20
      }).then(response => {
        if (response.data.items.length > 0) {
          this.dlgData = response.data.items[0]
          this.dlgVisible = true
        }
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
.detail-table {
  width: 100%;
  th, td {
    border: 1px solid black;
    border-collapse: collapse;
    padding: 5px;
  }
  th {
    text-align: left;
  }
}
.link-type,
.link-type:focus {
  color: #337ab7;
  cursor: pointer;

  &:hover {
    color: rgb(32, 160, 255);
  }
}
</style>
