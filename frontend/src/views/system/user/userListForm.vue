<template>
  <a-modal
    title="选择用户"
    :width="900"
    :visible="visible"
    @ok="handleSubmit"
    @cancel="handleCancel"
  >
    <a-row :gutter="24">
      <a-col :md="5" :sm="24" style="padding: 0 0 0 0;">
        <a-card :bordered="false" :loading="treeLoading" >
          <div v-if="this.orgTree != ''">
            <a-tree
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
        <x-card v-if="hasPerm('sysUser:page')">
          <div slot="content" class="table-page-search-wrapper">
            <a-form layout="inline">
              <a-row :gutter="48">
                <a-col :md="8" :sm="24">
                  <a-form-item label="关键词">
                    <a-input v-model="queryParam.searchValue" allow-clear placeholder="请输入姓名、账号、手机号" />
                  </a-form-item>
                </a-col>
                <a-col :md="8" :sm="24">
                  <a-form-item label="状态">
                    <a-select v-model="queryParam.searchStatus" allow-clear placeholder="请选择状态" default-value="0">
                      <a-select-option v-for="(item,index) in statusDictTypeDropDown" :key="index" :value="item.code">
                        {{ item.value }}</a-select-option>
                    </a-select>
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
            :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }">
            <span slot="sex" slot-scope="text">
              {{ sexFilter(text) }}
            </span>
            <span slot="status" slot-scope="text">
              {{ statusFilter(text) }}
            </span>
          </s-table>
        </a-card>
      </a-col>
    </a-row>
  </a-modal>
</template>
<script>
  import {
    STable,
    XCard
  } from '@/components'
  import {
    Empty
  } from 'ant-design-vue'
  import {
    getOrgTree
  } from '@/api/modular/system/orgManage'
  import {
    getUserPage
  } from '@/api/modular/system/userManage'
  import {
    sysDictTypeDropDown
  } from '@/api/modular/system/dictManage'
  export default {
    components: {
      XCard,
      STable,
    },
    data() {
      return {
        // 高级搜索 展开/关闭
        advanced: false,
        visible:false,
        // 查询参数
        queryParam: {},
        // 表头
        columns: [{
            title: '账号',
            dataIndex: 'account'
          },
          {
            title: '姓名',
            dataIndex: 'name'
          },
          {
            title: '性别',
            dataIndex: 'sex',
            scopedSlots: {
              customRender: 'sex'
            }
          }, {
            title: '手机',
            dataIndex: 'phone'
          },
          {
            title: '状态',
            dataIndex: 'status',
            scopedSlots: {
              customRender: 'status'
            }
          }
        ],
        // 加载数据方法 必须为 Promise 对象
        loadData: parameter => {
          return getUserPage(Object.assign(parameter, this.queryParam)).then((res) => {
            return res.data
          })
        },
        orgTree: [],
        selectedRowKeys: [],
        selectedRows: [],
        defaultExpandedKeys: [],
        sexDictTypeDropDown: [],
        statusDictTypeDropDown: [],
        treeLoading: true,
        simpleImage: Empty.PRESENTED_IMAGE_SIMPLE,
        replaceFields: {
          key: 'id'
        }
      }
    },
    methods: {
      userList(record) {
        this.visible = true
        /**
         * 获取到机构树，展开顶级下树节点，考虑到后期数据量变大，不建议全部展开
         */
        getOrgTree(Object.assign(this.queryParam)).then(res => {
          this.treeLoading = false
          if (!res.success) {
            return
          }
          this.orgTree = res.data
          for (var item of res.data) {
            // eslint-disable-next-line eqeqeq
            if (item.parentId == 0) {
              this.defaultExpandedKeys.push(item.id)
            }
          }
        })
        this.sysDictTypeDropDown()
      },
      sexFilter(sex) {
        // eslint-disable-next-line eqeqeq
        const values = this.sexDictTypeDropDown.filter(item => item.code == sex)
        if (values.length > 0) {
          return values[0].value
        }
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
          code: 'sex'
        }).then((res) => {
          this.sexDictTypeDropDown = res.data
        })
        sysDictTypeDropDown({
          code: 'common_status'
        }).then((res) => {
          this.statusDictTypeDropDown = res.data
        })
      },
      
      /**
       * 点击左侧机构树查询列表
       */
      handleClick(e) {
        this.queryParam = {
          'sysEmpParam.orgId': e.toString()
        }
        this.$refs.table.refresh(true)
      },
      toggleAdvanced() {
        this.advanced = !this.advanced
      },

      onSelectChange(selectedRowKeys, selectedRows) {
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
