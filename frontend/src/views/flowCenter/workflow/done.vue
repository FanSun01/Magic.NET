<template>
  <div>
    <x-card v-if="hasPerm('flcFlowinstance:page')">
      <div slot="content" class="table-page-search-wrapper">
        <a-form layout="inline">
          <a-row :gutter="48">
            <a-col :md="8" :sm="24">
              <a-form-item label="申请名称" >
                <a-input v-model="queryParam.customName" allow-clear placeholder="请输入申请名称"/>
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
        <span slot="isFinish" slot-scope="text, record">
          <a-tag
            :color="tags[record.isFinish]"
          >
            {{ statusFilter(text) }}
          </a-tag>
        </span>
        <span slot="action" slot-scope="text, record">
          <template v-if="hasPerm('flcFlowinstance:detail')">
            <a @click="$refs.previewForm.edit(record)">查看</a>
          </template>
        </span>
      </s-table>
      <preview-form ref="previewForm" @ok="handleOk" />
    </a-card>
  </div>
</template>
<script>
  import { STable, XCard } from '@/components'
  import { flowinstancePage} from '@/api/modular/flowCenter/flowinstanceManage'
  import previewForm from './previewForm'
  import {
    sysDictTypeDropDown
  } from '@/api/modular/system/dictManage'
  export default {
    props: [ 'data'],
    components: {
      XCard,
      STable,
      previewForm
    },
    data () {
      return {
        // 高级搜索 展开/关闭
        advanced: false,
        // 查询参数
        queryParam: {lookType:2},
        // 表头
        columns: [
          {
            title: '申请编号',
            dataIndex: 'code'
          },
          {
            title: '申请名称',
            dataIndex: 'customName'
          },
          {
            title: '当前节点',
            dataIndex: 'activityName'
          },
          {
            title: '申请时间',
            dataIndex: 'createdTime'
          },{
            title: '申请人',
            dataIndex: 'createdUserName'
          },
          {
            title: '流程状态',
            dataIndex: 'isFinish',
            scopedSlots: {
              customRender: 'isFinish'
            }
          }
        ],
        // 加载数据方法 必须为 Promise 对象
        loadData: parameter => {
          return flowinstancePage(Object.assign(parameter, this.queryParam)).then((res) => {
            return res.data
          })
        },
        selectedRowKeys: [],
        selectedRows: [],
        statusDict: [],
        tags:{0:"#5bc0de",//正在处理
              1:"#7ccb7c",//已完成
              3:"#d9534f",//不同意
              2:"#faad14",//被撤回
              4:"#faad14"}//被驳回
      }
    },
    created () {
      this.sysDictTypeDropDown()
      if (this.hasPerm('flcFlowinstance:cancel') ||this.hasPerm('flcFlowinstance:verification') || this.hasPerm('flcFlowinstance:detail')||this.hasPerm('flcFlowinstance:edit') || this.hasPerm('flcFlowinstance:delete')) {
        this.columns.push({
          title: '操作',
          width: '100px',
          dataIndex: 'action',
          scopedSlots: { customRender: 'action' }
        })
      }
    },
    methods: {
      statusFilter(status) {
        // eslint-disable-next-line eqeqeq
        const values = this.statusDict.filter(item => item.code == status)
        if (values.length > 0) {
          return values[0].value
        }
      },
      /**
       * 获取字典数据
       */
      sysDictTypeDropDown() {
        sysDictTypeDropDown({
          code: 'flow_status'
        }).then((res) => {
          this.statusDict = res.data
        })
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
