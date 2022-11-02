<template>
  <div>
    <a-alert message="该功能只适配了SqlServer、MySQL数据库,其他数据库请自行研究" banner closable type="info" how-icon/>
    <a-row :gutter="24">
      <a-col :md="9" :sm="24" style="padding: 0 0 0 0;">
        <a-card :bordered="false">
          <s-table ref="table" :columns="tableShowColumns" :data="tableData" :alert="true"
            :rowKey="(record) => record.name" :showPagination="false" :customRow="rowClick">
            <template slot="operator" v-if="hasPerm('table:add')">
              <a-button @click="$refs.addTableForm.add()" icon="plus" type="primary" v-if="hasPerm('table:add')">新增数据表
              </a-button>
            </template>
            <span slot="action" slot-scope="text, record">
              <a v-if="hasPerm('table:edit')" @click.stop="$refs.editTableForm.edit(record)">编辑</a>
              <a-divider type="vertical" v-if="hasPerm('table:delete')" />
              <a-popconfirm v-if="hasPerm('table:delete')" placement="topRight" title="确认删除？"
                @confirm="() => tableDelete(record)">
                <a>删除</a>
              </a-popconfirm>
              <a-divider type="vertical" v-if="hasPerm('table:createEntity')" />
              <a v-if="hasPerm('table:createEntity')" @click.stop="showModal(record.name)">生成实体</a>
            </span>
          </s-table>
          <add-table-form ref="addTableForm" @ok="tableHandleOk" />
          <edit-table-form ref="editTableForm" @ok="tableHandleOk" />
        </a-card>
      </a-col>
      <a-col :md="15" :sm="24">
        <a-card :bordered="false">
          <s-table ref="columnTable" :columns="columnShowColumns" :data="columnInfo" :alert="true"
            :rowKey="(record) => record.dbColumnName" :showPagination="false">
            <template slot="operator" v-if="hasPerm('table:add') && queryParam.tableName">
              <a-button @click="$refs.addColumnForm.add(queryParam.tableName)" icon="plus" type="primary"
                v-if="hasPerm('column:add')">新增({{queryParam.tableName}})数据列
              </a-button>
            </template>
            <template slot="isPrimarykey" slot-scope="text, record">
              <span>{{record.isPrimarykey?'是':'否'}}</span>
            </template>
            <template slot="isIdentity" slot-scope="text, record">
              <span>{{record.isIdentity?'是':'否'}}</span>
            </template>
            <template slot="isNullable" slot-scope="text, record">
              <span>{{record.isNullable?'是':'否'}}</span>
            </template>
            <span slot="action" slot-scope="text, record">
              <a v-if="hasPerm('column:edit')" @click="$refs.editColumnForm.edit(record)">编辑</a>
              <a-divider type="vertical" v-if="hasPerm('column:delete')" />
              <a-popconfirm v-if="hasPerm('column:delete')" placement="topRight" title="确认删除？"
                @confirm="() => columnDelete(record)">
                <a>删除</a>
              </a-popconfirm>
            </span>
          </s-table>
          <add-column-form ref="addColumnForm" @ok="columnHandleOk" />
          <edit-column-form ref="editColumnForm" @ok="columnHandleOk" />
        </a-card>
      </a-col>
      <a-modal :visible="createEntityVisible" title='配置实体名' okText='确认' cancel-text="取消" @cancel="modalCancel"
        @ok="createEntity">
        <a-form :form="createEntityForm">
          <span style="color: red;">会覆盖同一路径下的同名文件，慎重。生成完需要重新编译！</span>
          <br />
          <span style="color: red;">基类不知道什么意思的去看项目里面这四个类！</span>
          <a-form-item v-show="false">
            <a-input v-decorator="['tableName']" />
          </a-form-item>
          <a-form-item label="实体名称">
            <a-input placeholder="请输入实体名称"
              v-decorator="['entityName', { rules: [{ required: true, message: '请输入实体名称!' }] }]" width="100%"></a-input>
          </a-form-item>
          <a-form-item label="基类">
            <a-select key="baseClassName" style="width: 100%" placeholder="请选择" has-feedback
              v-decorator="['baseClassName']">
              <a-select-option v-for="(item,index) in baseClassOptions" :key="index" :value="item">{{ item }}
              </a-select-option>
            </a-select>
          </a-form-item>
          <a-form-item label="存放位置">
            <a-select key="position" style="width: 100%" placeholder="请选择" has-feedback
              v-decorator="['position', { rules: [{ required: true, message: '请选择存放位置!' }] }]">
              <a-select-option v-for="(item,index) in positionOption" :key="index" :value="item">{{ item }}
              </a-select-option>
            </a-select>
          </a-form-item>
        </a-form>
      </a-modal>
    </a-row>
  </div>



</template>
<script>
  import {
    STable
  } from '@/components'
  import {
    getTableInfoList,
    getColumnInfoList,
    tableDelete,
    columnDelete,
    createEntity
  } from '@/api/modular/gen/databaseManage'
  import addTableForm from './addTableForm.vue'
  import editTableForm from './editTableForm.vue'
  import addColumnForm from './addColumnForm.vue'
  import editColumnForm from './editColumnForm.vue'
  export default {
    components: {
      STable,
      addTableForm,
      editTableForm,
      editColumnForm,
      addColumnForm
    },
    data() {
      return {
        createEntityForm: this.$form.createForm(this),
        createEntityParams: {
          entityName: '',
          tableName: '',
          baseClassName: '',
          position: ''
        },
        baseClassOptions: [
          'PrimaryKeyEntity',
          'AutoIncrementEntity',
          'DEntityBase',
          'DBEntityTenant'
        ],
        positionOption: [
          'Magic.Application',
          'Magic.Core'
        ],
        createEntityVisible: false,
        tableLoading: false,
        columnLoading: false,
        queryParam: {},
        tableShowColumns: [{
            title: '表名',
            dataIndex: 'name'
          },
          {
            title: '描述',
            dataIndex: 'description'
          }
        ],
        columnShowColumns: [{
          title: '字段名',
          dataIndex: 'dbColumnName'
        }, {
          title: '描述',
          dataIndex: 'columnDescription'
        }, {
          title: '主键',
          dataIndex: 'isPrimarykey',
          scopedSlots: {
            customRender: 'isPrimarykey'
          }
        }, {
          title: '自增',
          dataIndex: 'isIdentity',
          scopedSlots: {
            customRender: 'isIdentity'
          }
        }, {
          title: '可空',
          dataIndex: 'isNullable',
          scopedSlots: {
            customRender: 'isNullable'
          }
        }, {
          title: '类型',
          dataIndex: 'dataType'
        }],
        columnInfo: parameter => {
          return getColumnInfoList(this.queryParam).then((res) => {
            return res.data
          })
        },
        tableData: parameter => {
          return getTableInfoList(Object.assign(parameter)).then((res) => {
            return res.data
          })
        },
        rowClick: (record, index) => ({
          on: {
            click: () => {
              this.queryParam = {
                'tableName': record.name
              }
              this.$refs.columnTable.refresh(true)
            },
          },
        })
      };
    },
    created() {
      if (this.hasPerm('table:edit') || this.hasPerm('table:delete')) {
        this.tableShowColumns.push({
          title: '操作',
          width: '200px',
          dataIndex: 'action',
          scopedSlots: {
            customRender: 'action'
          }
        })
      }
      if (this.hasPerm('column:edit') || this.hasPerm('column:delete')) {
        this.columnShowColumns.push({
          title: '操作',
          width: '200px',
          dataIndex: 'action',
          scopedSlots: {
            customRender: 'action'
          }
        })
      }
    },
    methods: {
      showModal(tableName) {
        console.log(tableName);
        this.createEntityVisible = true;
        setTimeout(() => {
          this.createEntityForm.setFieldsValue({
            tableName: tableName
          });
        }, 100)

      },
      createEntity() {
        this.createEntityForm.validateFields((errors, values) => {
          if (!errors) {
            createEntity(values).then((res) => {
              if (res.success) {
                this.$message.success('生成成功')
                this.modalCancel()
              } else {
                this.$message.error('生成失败')
              }
            })
          }
        });
      },
      modalCancel() {
        this.createEntityVisible = false;
        this.createEntityForm.resetFields()
      },
      tableHandleOk() {
        this.$refs.table.refresh()
      },
      columnHandleOk() {
        this.$refs.columnTable.refresh()
      },
      tableDelete(record) {
        tableDelete(record).then((res) => {
          if (res.success) {
            this.$message.success('删除成功')
            this.$refs.table.refresh()
            this.$refs.columnTable.refresh()
          } else {
            this.$message.error('删除失败') // + res.message
          }
        })
      },
      columnDelete(record) {
        columnDelete(record).then((res) => {
          if (res.success) {
            this.$message.success('删除成功')
            this.$refs.columnTable.refresh()
          } else {
            this.$message.error('删除失败') // + res.message
          }
        })
      }
    }
  };
</script>
<style></style>
