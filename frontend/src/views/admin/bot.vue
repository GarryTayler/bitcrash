<template>
  <div class="admin-page">
    <div class="filter-container">
      <!-- <el-input v-model="listQuery.search_key" placeholder="Name" style="width: 200px" @keyup.enter.native="handleFilter" />
      <el-button class="m-l" type="primary" @click="handleFilter">
        Search
      </el-button> -->
      <el-button class="m-l" type="primary" @click="handleAdd">
        Add
      </el-button>
    </div>
    <el-table v-loading="listLoading" class="m-t" :data="list" border fit highlight-current-row style="width: 100%">
      <el-table-column align="center" label="ID" width="80">
        <template slot-scope="scope">
          <span>{{ scope.row.ID }}</span>
        </template>
      </el-table-column>

      <el-table-column width="170px" align="center" label="BotID">
        <template slot-scope="scope">
          <span>{{ scope.row.F_ID }}</span>
        </template>
      </el-table-column>

      <el-table-column width="100px" align="center" label="Base Value">
        <template slot-scope="scope">
          <span>{{ scope.row.BASE_VALUE }}</span>
        </template>
      </el-table-column>

      <el-table-column width="100px" align="center" label="BUST From">
        <template slot-scope="scope">
          <span>{{ scope.row.BUST_FROM }}</span>
        </template>
      </el-table-column>

      <el-table-column width="100px" align="center" label="BUST To">
        <template slot-scope="scope">
          <span>{{ scope.row.BUST_TO }}</span>
        </template>
      </el-table-column>

      <el-table-column width="100px" align="center" label="Status">
        <template slot-scope="scope">
          <span>{{ scope.row.ENABLE == 1 ? 'Enabled' : 'Disabled' }}</span>
        </template>
      </el-table-column>

      <el-table-column align="center" label="Actions">
        <template slot-scope="{row}">
          <el-button v-if="row.ENABLE == 0" type="primary" size="small" @click="handleEnable(row)">
            Enable
          </el-button>
          <el-button v-if="row.ENABLE == 1" type="info" size="small" @click="handleDisable(row)">
            Disable
          </el-button>
          <el-button type="danger" size="small" @click="handleDel(row)">
            Delete
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList" />

    <el-dialog :title="dlgTextMap[dlgStatus]" :visible.sync="dlgVisible">
      <el-form ref="temp" :rules="rules" :model="temp" label-position="left" label-width="130px" style="width: 400px margin-left:50px">
        <el-form-item label="BotId" prop="bot_id">
          <el-input v-model="temp.bot_id" placeholder="Bot ID" />
        </el-form-item>
        <el-form-item label="Base Value" prop="base_value">
          <el-input v-model="temp.base_value" placeholder="Base Value" />
        </el-form-item>
        <el-form-item label="Bust From" prop="bust_from">
          <el-input v-model="temp.bust_from" placeholder="Bust From" />
        </el-form-item>
        <el-form-item label="Bust To" prop="bust_to">
          <el-input v-model="temp.bust_to" placeholder="Bust To" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dlgVisible = false">
          Cancel
        </el-button>
        <el-button type="primary" @click="dlgStatus==='create'?createBot():updateBot()">
          Ok
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { fetchList, updateBot, addBot } from '@/api/bot'
import Pagination from '@/components/Pagination' // Secondary package based on el-pagination

export default {
  components: {
    Pagination
  },
  props: {},
  data() {
    const validateRequire = (rule, value, callback) => {
      if (value === '') {
        this.$message({
          message: 'Content is empty.',
          type: 'warning'
        })
        callback(new Error('Content is empty.'))
      } else {
        callback()
      }
    }
    const validateNumberRequire = (rule, value, callback) => {
      if (isNaN(parseFloat(value)) || parseFloat(value) < 0) {
        this.$message({
          message: 'This value is unsigned float.',
          type: 'warning'
        })
        callback(new Error('This value is unsigned float.'))
      } else {
        callback()
      }
    }
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        page: 1,
        limit: 20
      },
      temp: {
        bot_id: '',
        base_value: '',
        bust_from: '',
        bust_to: '',
        enable: '1'
      },
      dlgVisible: false,
      dlgStatus: 'create',
      dlgTextMap: {
        update: 'Update',
        create: 'Add'
      },
      rules: {
        reason: [
          { required: true, trigger: 'blur', validator: validateRequire }
        ],
        base_value: [
          { required: true, trigger: 'blur', validator: validateNumberRequire }
        ],
        bust_from: [
          { required: true, trigger: 'blur', validator: validateNumberRequire }
        ],
        bust_to: [
          { required: true, trigger: 'blur', validator: validateNumberRequire }
        ]
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
    resetTemp() {
      this.temp = {
        bot_id: '',
        base_value: '',
        bust_from: '',
        bust_to: '',
        enable: '1'
      }
    },
    handleAdd() {
      this.resetTemp()
      this.dlgStatus = 'create'
      this.dlgVisible = true
      this.$nextTick(() => {
        this.$refs['temp'].clearValidate()
      })
    },
    createBot() {
      this.$refs['temp'].validate(valid => {
        if (valid) {
          addBot(this.temp)
            .then(response => {
              this.dlgVisible = false
              this.getList()
            })
            .catch(err => {
              console.log(err)
              this.dlgVisible = false
            })
        }
      })
    },
    updateBot() {},
    handleEnable(row) {
      updateBot({ id: row.ID, enable: '1' }).then(response => {
        this.getList()
      })
    },
    handleDisable(row) {
      updateBot({ id: row.ID, enable: '0' }).then(response => {
        this.getList()
      })
    },
    handleDel(row) {
      updateBot({ id: row.ID, deleted: 1 }).then(response => {
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
