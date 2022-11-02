<template>
  <a-row :gutter="24" >
    <a-col :md="24" :sm="24" style="padding: 0 0 0 0;">
      <x-card v-if="hasPerm('flcFlowscheme:page')">
        <div slot="content" class="table-page-search-wrapper">
          <a-form layout="inline">
            <a-row :gutter="48">
              <a-col :md="8" :sm="24">
                <a-form-item label="流程名称" >
                  <a-input v-model="queryParam.name" allow-clear placeholder="请输入流程名称"/>
                </a-form-item>
              </a-col>
              <a-col :md="8" :sm="24">
                <a-button type="primary" @click="$refs.table.refresh(true)">查询</a-button>
                <a-button style="margin-left: 8px" @click="() => queryParam = {}">重置</a-button>
              </a-col>
              <a-col :md="8" :sm="24">
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
          <span slot="action" slot-scope="text, record">
            <a v-if="hasPerm('flcFlowinstance:add')" @click="$refs.addForm.edit(record)">创建申请</a>
          </span>
        </s-table>
        <add-form ref="addForm" @ok="handleOk" />
      </a-card>
    </a-col>
  </a-row>
</template>
<script>
  import { STable, XCard } from '@/components'
  import { Empty } from 'ant-design-vue'
  import { getFlcFlowschemePage } from '@/api/modular/flowCenter/flowManage'
  import addForm from './addForm'
  export default {
    props: [ 'data'],
    components: {
      XCard,
      STable,
      addForm,
    },
    data () {
      return {
        // 高级搜索 展开/关闭
        advanced: false,
        // 查询参数
        queryParam: {status:0},
        // 表头
        columns: [
          {
            title: '流程编号',
            dataIndex: 'schemeCode'
          },
          {
            title: '流程名称',
            dataIndex: 'schemeName'
          },
          {
            title: '排序',
            dataIndex: 'sort'
          },
          {
            title: '备注',
            dataIndex: 'remark'
          }
        ],
        // 加载数据方法 必须为 Promise 对象
        loadData: parameter => {
          return getFlcFlowschemePage(Object.assign(parameter, this.queryParam)).then((res) => {
            return res.data
          })
        },
        orgTree: [],
        selectedRowKeys: [],
        selectedRows: [],
        defaultExpandedKeys: [],
        // 搜索的三个参数
        expandedKeys: [],
        searchValue: '',
        autoExpandParent: true,
        treeLoading: true,
        simpleImage: Empty.PRESENTED_IMAGE_SIMPLE,
        replaceFields: {
          key: 'id'
        }
      }
    },
    created () {
      if (this.hasPerm('flcFlowinstance:add')) {
        this.columns.push({
          title: '操作',
          width: '100px',
          dataIndex: 'action',
          scopedSlots: { customRender: 'action' }
        })
      }
    },
    methods: {
      toggleAdvanced () {
        this.advanced = !this.advanced
      },
      handleOk () {
        this.$refs.table.refresh()
      },
      onSelectChange (selectedRowKeys, selectedRows) {
        this.selectedRowKeys = selectedRowKeys
        this.selectedRows = selectedRows
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
