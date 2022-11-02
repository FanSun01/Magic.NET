<template>
  <a-modal
    title="选择角色"
    :width="900"
    :visible="visible"
    @ok="handleSubmit"
    @cancel="handleCancel"
  >
    <x-card v-if="hasPerm('sysRole:page')">
      <div slot="content" class="table-page-search-wrapper">
        <a-form layout="inline">
          <a-row :gutter="48">
            <a-col :md="8" :sm="24">
              <a-form-item label="角色名">
                <a-input v-model="queryParam.name" allow-clear placeholder="请输入角色名"/>
              </a-form-item>
            </a-col>
            <a-col :md="8" :sm="24">
              <a-form-item label="唯一编码">
                <a-input v-model="queryParam.code" allow-clear placeholder="请输入唯一编码"/>
              </a-form-item>
            </a-col>
            <a-col :md="8" :sm="24">
              <a-button type="primary" @click="$refs.table.refresh(true)">查询</a-button>
              <a-button style="margin-left: 8px" @click="() => queryParam = {}">重置</a-button>
            </a-col>
          </a-row>
        </a-form>
      </div>
    </x-card>
    <a-card :bordered="false">
      <s-table
        ref="table"
        :columns="columns"
        :data="loadData"
        :alert="true"
        :rowKey="(record) => record.id"
        :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }"
      >

      </s-table>

    </a-card>
  </a-modal>
</template>

<script>
  import { STable, XCard } from '@/components'
  import { getRolePage } from '@/api/modular/system/roleManage'
  export default {
    components: {
      XCard,
      STable,
    },

    data () {
      return {
        // 查询参数
        queryParam: {},
        visible:false,
        // 表头
        columns: [
          {
            title: '角色名',
            dataIndex: 'name'
          },
          {
            title: '唯一编码',
            dataIndex: 'code'
          },
          {
            title: '排序',
            dataIndex: 'sort'
          }
        ],
        // 加载数据方法 必须为 Promise 对象
        loadData: parameter => {
          return getRolePage(Object.assign(parameter, this.queryParam)).then((res) => {
            return res.data
          })
        },
        selectedRowKeys: [],
        selectedRows: []
    }
    },

    methods: {
      roleList(record) {
        this.visible = true
      },
      onSelectChange (selectedRowKeys, selectedRows) {
        this.selectedRowKeys = selectedRowKeys
        this.selectedRows = selectedRows
      },
      handleSubmit () {
        this.visible = false
				this.$emit('ok',this.selectedRows);
      },
      handleCancel () {
        this.visible = false
      }
    }

  }
</script>

<style lang="less">
  .table-operator {
    margin-bottom: 18px;
  }
  button {
    margin-right: 8px;
  }

</style>
