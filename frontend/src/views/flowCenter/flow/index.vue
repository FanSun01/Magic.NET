<template>
  <a-row :gutter="24" >
    <a-col :md="5" :sm="24" style="padding: 0 0 0 0;">
      <a-card :bordered="false" :loading="treeLoading" class="leftTree">
        <div v-if="this.orgTree!='' ">
          <a-tree
            style="scroll:true"
            :treeData="orgTree"
            v-if="orgTree.length"
            @select="handleClick"
            :defaultExpandAll="true"
            :defaultExpandedKeys="defaultExpandedKeys"
            :replaceFields="replaceFields" />
        </div>
        <div v-else>
          <a-empty :image="simpleImage" />
        </div>
      </a-card>
    </a-col>
    <a-col :md="19" :sm="24">
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
          <template slot="operator" v-if="hasPerm('flcFlowscheme:add')">
            <a-button @click="$refs.addForm.add()" icon="plus" type="primary" v-if="hasPerm('flcFlowscheme:add')">新增流程</a-button>
          </template>
          <span slot="status" slot-scope="text,record" v-if="hasPerm('flcFlowscheme:changeStatus')">
            <a-popconfirm
              placement="top"
              :title="text===0? '确定停用该流程？':'确定启用该流程？'"
              @confirm="() => changeStatus(text,record)">
              <a>{{ statusFilter(text) }}</a>
            </a-popconfirm>
          </span>
          <span slot="status" v-else>
            {{ statusFilter(text) }}
          </span>
          <span slot="action" slot-scope="text, record">
            <a v-if="hasPerm('flcFlowscheme:design')" @click="$refs.designForm.edit(record)">设计</a>
            <a-divider type="vertical" v-if="hasPerm('flcFlowscheme:design')" />
            <template v-if="hasPerm('flcFlowscheme:preview')">
              <a @click="$refs.previewForm.edit(record)">预览</a>
            </template>
            <a-divider type="vertical" v-if="hasPerm('flcFlowscheme:preview') && (hasPerm('flcFlowscheme:edit') || hasPerm('flcFlowscheme:delete'))" />
            <a-dropdown v-if="hasPerm('flcFlowscheme:edit') || hasPerm('flcFlowscheme:delete')">
              <a class="ant-dropdown-link">
                更多 <a-icon type="down" />
              </a>
              <a-menu slot="overlay">
                <a-menu-item v-if="hasPerm('flcFlowscheme:edit')">
                  <a @click="$refs.editForm.edit(record)">编辑</a>
                </a-menu-item>
                <a-menu-item v-if="hasPerm('flcFlowscheme:delete')">
                  <a-popconfirm placement="topRight" title="确认删除？" @confirm="() => flcFlowschemeDelete(record)">
                    <a>删除</a>
                  </a-popconfirm>
                </a-menu-item>
              </a-menu>
            </a-dropdown>
          </span>
        </s-table>
        <add-form ref="addForm" @ok="handleOk" />
        <edit-form ref="editForm" @ok="handleOk" />
        <design-form ref="designForm" @ok="handleOk" />
        <preview-form ref="previewForm" @ok="handleOk" />
      </a-card>
    </a-col>
  </a-row>
</template>
<script>
  import { STable, XCard } from '@/components'
  import { Empty } from 'ant-design-vue'
  import { getOrgTree } from '@/api/modular/system/orgManage'
  import { getFlcFlowschemePage, flcFlowschemeDelete, flcFlowschemeEdit } from '@/api/modular/flowCenter/flowManage'
  import addForm from './addForm'
  import editForm from './editForm'
  import designForm from './designForm'
  import previewForm from './previewForm'
  import {
    sysDictTypeDropDown
  } from '@/api/modular/system/dictManage'
  export default {
    props: [ 'data'],
    components: {
      XCard,
      STable,
      addForm,
      editForm,
      designForm,
      previewForm
    },
    data () {
      return {
        // 高级搜索 展开/关闭
        advanced: false,
        // 查询参数
        queryParam: {},
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
            title: '状态',
            dataIndex: 'status',
            scopedSlots: {
              customRender: 'status'
            }
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
        statusDictTypeDropDown: [],
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
      this.getOrgTree()
      this.sysDictTypeDropDown()
      if (this.hasPerm('flcFlowscheme:design') || this.hasPerm('flcFlowscheme:preview') || this.hasPerm('flcFlowscheme:edit') || this.hasPerm('flcFlowscheme:delete')) {
        this.columns.push({
          title: '操作',
          width: '190px',
          dataIndex: 'action',
          scopedSlots: { customRender: 'action' }
        })
      }
    },
    methods: {
      /**
       * 获取到流程树，展开顶级下树节点，考虑到后期数据量变大，不建议全部展开
       */
      getOrgTree () {
        getOrgTree(Object.assign(this.queryParam)).then(res => {
          this.treeLoading = false
          if (!res.success) {
            return
          }
          this.orgTree = res.data
          this.queryParam.parentId = this.orgTree[0].id
          // 全部展开，上面api方法提供的不生效，先用此方法
          for (var item of res.data) {
            // eslint-disable-next-line eqeqeq
            if (item.parentId == 0) {
              this.defaultExpandedKeys.push(item.id)
            }
          }
          this.$refs.table.refresh()
        })
      },
      statusFilter(status) {
        // eslint-disable-next-line eqeqeq
        const values = this.statusDictTypeDropDown.filter(item => item.code == status)
        if (values.length > 0) {
          return values[0].value
        }
      },
      /**
       * 获取字典数据
       */
      sysDictTypeDropDown(text) {
        sysDictTypeDropDown({
          code: 'common_status'
        }).then((res) => {
          this.statusDictTypeDropDown = res.data
        })
      },
      /**
       * 删除
       * @param record
       */
      flcFlowschemeDelete (record) {
        flcFlowschemeDelete(record).then((res) => {
          if (res.success) {
            this.$message.success('删除成功')
            this.$refs.table.refresh()
          } else {
            this.$message.error('删除失败：' + res.message)
          }
        }).catch((err) => {
          this.$message.error('删除错误：' + err.message)
        })
      },
      changeStatus (code, record) {
        // eslint-disable-next-line no-unused-vars
        const status = 0
        // eslint-disable-next-line eqeqeq
        if (code == 0) {
          this.status = 1
          // eslint-disable-next-line eqeqeq
        } else if (code == 1) {
          this.status = 0
        }
        flcFlowschemeEdit({
          id: record.id,
          status: this.status
        }).then(res => {
          if (res.success) {
            this.$message.success('操作成功')
            this.$refs.table.refresh()
          } else {
            this.$message.error('操作失败：' + res.message)
          }
        })
      },
      handleClick (e) {
        this.queryParam = {
          orgId: e.toString()
        }
        this.$refs.table.refresh(true)
      },
      toggleAdvanced () {
        this.advanced = !this.advanced
      },
      handleOk () {
        this.getOrgTree()
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
