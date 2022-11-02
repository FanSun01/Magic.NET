<template>
  <a-modal title="新增数据表" :width="1200" :visible="visible" :confirmLoading="confirmLoading" @ok="handleSubmit"
    @cancel="handleCancel">

    <a-spin :spinning="confirmLoading">
      <a-divider orientation="left">数据表信息</a-divider>
      <a-form :form="form">
        <a-form-item label="表名" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input placeholder="请输入表名" v-decorator="['name',{rules: [{required: true, message: '请输入表名！'}]}]" />
        </a-form-item>
        <a-form-item label="描述" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input placeholder="请输入描述" style="width: 100%"
            v-decorator="['description',{rules: [{required: true, message: '请输入描述！'}]}]" />
        </a-form-item>
      </a-form>
    </a-spin>
    <a-spin :spinning="confirmLoading">
      <a-divider orientation="left">数据列信息</a-divider>
      <a-row :gutter="24">
        <a-col :md="24" :sm="24">
          <a-table size="middle" :columns="columnShowColumns" :dataSource="columnInfo" :pagination="false"
            :loading="false">
            <template slot="dbColumnName" slot-scope="text, record">
              <a-input style="width: 120px" v-model="record.dbColumnName" />
            </template>
            <template slot="columnDescription" slot-scope="text, record">
              <a-input style="width: 120px" v-model="record.columnDescription" />
            </template>
            <template slot="isPrimarykey" slot-scope="text, record">
              <a-select key="isPrimarykey" style="width: 120px" placeholder="请选择" has-feedback
                @change="e => primarykeyHandleChange(e,record.key)" v-model="record.isPrimarykey">
                <a-select-option v-for="(item,index) in selectData" :key="index" :value="item.value">{{ item.text }}
                </a-select-option>
              </a-select>
            </template>
            <template slot="isIdentity" slot-scope="text, record">
              <a-select key="isIdentity" style="width: 120px" placeholder="请选择" has-feedback v-model="record.isIdentity"
                :disabled="record.isPrimarykey==0">
                <a-select-option v-for="(item,index) in selectData" :key="index" :value="item.value">{{ item.text }}
                </a-select-option>
              </a-select>
            </template>
            <template slot="isNullable" slot-scope="text, record">
              <a-select key="isNullable" style="width: 120px" placeholder="请选择" has-feedback
                :disabled="record.isPrimarykey==1" v-model="record.isNullable">
                <a-select-option v-for="(item,index) in selectData" :key="index" :value="item.value">{{ item.text }}
                </a-select-option>
              </a-select>
            </template>
            <template slot="dataType" slot-scope="text, record">
              <a-select key="dataType" style="width: 120px" placeholder="请选择"
                @change="e => dataTypeHandleChange(e,record.key)" has-feedback v-model="record.dataType">
                <a-select-option v-for="(item,index) in dataTypeSelectData" :key="index" :value="item.value">
                  {{ item.value }}
                </a-select-option>
              </a-select>
            </template>
            <template slot="length" slot-scope="text, record">
              <a-input-number :disabled="!record.hasLength" v-model="record.length" />
            </template>
            <template slot="decimalDigits" slot-scope="text, record">
              <a-input-number :disabled="!record.hasDecimalDigits" v-model="record.decimalDigits" />
            </template>
            <template slot="operation" slot-scope="text, record">
              <a @click="remove(record.key)">删除</a>
            </template>

          </a-table>
          </a-form-item>
        </a-col>
      </a-row>
      <a-row type="flex">
        <a-col :span="6">
          <a-button style="width: 100%; margin-top: 16px; margin-bottom: 8px" type="dashed" icon="plus"
            @click="addPrimaryColumn">新增主键字段</a-button>
        </a-col>
        <a-col :span="6">
          <a-button style="width: 100%; margin-top: 16px; margin-bottom: 8px" type="dashed" icon="plus"
            @click="addColumn">新增普通字段</a-button>
        </a-col>
        <a-col :span="6">
          <a-button style="width: 100%; margin-top: 16px; margin-bottom: 8px" type="dashed" icon="plus"
            @click="addTenantColumn">新增租户字段</a-button>
        </a-col>
        <a-col :span="6">
          <a-button style="width: 100%; margin-top: 16px; margin-bottom: 8px" type="dashed" icon="plus"
            @click="addBaseColumn">新增基础字段</a-button>
        </a-col>
      </a-row>
    </a-spin>
  </a-modal>
</template>

<script>
  import {
    tableAdd
  } from '@/api/modular/gen/databaseManage'

  export default {
    data() {
      return {
        labelCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 5
          }
        },
        wrapperCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 15
          }
        },
        visible: false,
        confirmLoading: false,
        form: this.$form.createForm(this),
        selectData: [{
          text: '是',
          value: 1
        }, {
          text: '否',
          value: 0
        }],
        dataTypeSelectData: [{
            value: 'text',
            hasLength: false,
            hasDecimalDigits: false
          },
          {
            value: 'varchar',
            hasLength: true,
            hasDecimalDigits: false
          }, {
            value: 'nvarchar',
            hasLength: true,
            hasDecimalDigits: false
          },
          {
            value: 'char',
            hasLength: true,
            hasDecimalDigits: false
          }, {
            value: 'nchar',
            hasLength: true,
            hasDecimalDigits: false
          }, {
            value: 'timestamp',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'int',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'smallint',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'tinyint',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'bigint',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'bit',
            hasLength: false,
            hasDecimalDigits: false
          }, {
            value: 'decimal',
            hasLength: true,
            hasDecimalDigits: true
          }, {
            value: 'datetime',
            hasLength: false,
            hasDecimalDigits: false
          },
        ],
        columnInfo: [],
        columnShowColumns: [{
            title: '字段名',
            dataIndex: 'dbColumnName',
            scopedSlots: {
              customRender: 'dbColumnName'
            }
          }, {
            title: '描述',
            dataIndex: 'columnDescription',
            scopedSlots: {
              customRender: 'columnDescription'
            }
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
            title: '类型',
            dataIndex: 'dataType',
            scopedSlots: {
              customRender: 'dataType'
            }
          },
          {
            title: '可空',
            dataIndex: 'isNullable',
            scopedSlots: {
              customRender: 'isNullable'
            }
          },
          {
            title: '长度',
            dataIndex: 'length',
            scopedSlots: {
              customRender: 'length'
            }
          },
          {
            title: '保留几位小数',
            dataIndex: 'decimalDigits',
            scopedSlots: {
              customRender: 'decimalDigits'
            }
          },
          {
            title: '操作',
            key: 'action',
            scopedSlots: {
              customRender: 'operation'
            }
          }
        ],
      }
    },
    methods: {
      /**
       * 选择子表单单项触发
       */
      dataTypeHandleChange(value, key) {
        const newData = [...this.columnInfo]
        const target = newData.find(item => key === item.key)
        if (target) {
          let type = this.dataTypeSelectData.find(item => item.value == value);
          if (type) {
            target["hasLength"] = type.hasLength
            target["hasDecimalDigits"] = type.hasDecimalDigits
            if (!target["hasLength"]) {
              target["length"] = 0
            }
            if (!target["hasDecimalDigits"]) {
              target["decimalDigits"] = 0
            }
            this.columnInfo = newData
          }
        }
      },
      primarykeyHandleChange(value, key) {
        const newData = [...this.columnInfo]
        const target = newData.find(item => key === item.key)
        if (target) {
          if (value == 1) {
            target["isNullable"] = 0;
          } else {
            target["isIdentity"] = 0;
          }
          this.columnInfo = newData
        }
      },
      /**
       * 删除
       */
      remove(key) {
        const newData = this.columnInfo.filter(item => item.key !== key)
        this.columnInfo = newData
      },
      addColumn() {
        const length = this.columnInfo.length
        this.columnInfo.push({
          key: length === 0 ? 1 : parseInt(this.columnInfo[length - 1].key) + 1,
          columnDescription: "",
          dataType: "",
          dbColumnName: "",
          decimalDigits: 0,
          isIdentity: 0,
          isNullable: 1,
          isPrimarykey: 0,
          length: 0
        })
      },
      addTenantColumn() {
        const length = this.columnInfo.length
        this.columnInfo.push({
          key: length === 0 ? 1 : parseInt(this.columnInfo[length - 1].key) + 1,
          columnDescription: "租户Id",
          dataType: "bigint",
          dbColumnName: "TenantId",
          decimalDigits: 0,
          isIdentity: 0,
          isNullable: 1,
          isPrimarykey: 0,
          length: 0
        })
      },
      addPrimaryColumn() {
        const length = this.columnInfo.length
        this.columnInfo.push({
          key: length === 0 ? 1 : parseInt(this.columnInfo[length - 1].key) + 1,
          columnDescription: "主键Id",
          dataType: "bigint",
          dbColumnName: "Id",
          decimalDigits: 0,
          isIdentity: 0,
          isNullable: 0,
          isPrimarykey: 1,
          length: 0
        })
      },
      addBaseColumn() {
        const fileds = [{
            dataType: 'datetime',
            name: 'CreatedTime',
            desc: '创建时间'
          },
          {
            dataType: 'datetime',
            name: 'UpdatedTime',
            desc: '更新时间'
          },
          {
            dataType: 'bigint',
            name: 'CreatedUserId',
            desc: '创建者Id'
          },
          {
            dataType: 'nvarchar',
            name: 'CreatedUserName',
            desc: '创建者名称',
            length: 20
          },
          {
            dataType: 'bigint',
            name: 'UpdatedUserId',
            desc: '修改者Id'
          },
          {
            dataType: 'nvarchar',
            name: 'UpdatedUserName',
            desc: '修改者名称',
            length: 20
          },
          {
            dataType: 'bit',
            name: 'IsDeleted',
            desc: '软删除',
            isNullable:0
          }
        ]

        fileds.forEach(m => {
          let length = this.columnInfo.length
          let key = length === 0 ? 1 : parseInt(this.columnInfo[length - 1].key) + 1
          this.columnInfo.push({
            key: key,
            columnDescription: m.desc,
            dataType: m.dataType,
            dbColumnName: m.name,
            decimalDigits: 0,
            isIdentity: 0,
            isNullable: m.isNullable===0?0:1,
            isPrimarykey: 0,
            length: m.length || 0
          })
        })

      },

      // 初始化方法
      add(record) {
        this.visible = true;
      },
      /**
       * 提交表单
       */
      handleSubmit() {
        let errMsg="";
        for(let i=0;i<this.columnInfo.length;i++){
          let m=this.columnInfo[i];
          if((m.dataType=="varchar" || m.dataType=="nvarchar") && m.length<=0){
            errMsg="字段类型为varchar或者nvarchar时，长度不能小于0"
            break;
          }
        }
        if(errMsg){
          this.$message.warning(errMsg);
          return false;
        }


        const {
          form: {
            validateFields
          }
        } = this
        this.confirmLoading = true
        validateFields((errors, values) => {
          if (!errors) {
            values["dbColumnInfoList"] = this.columnInfo;
            tableAdd(values).then((res) => {
              if (res.success) {
                this.$message.success('新增成功')
                this.confirmLoading = false
                this.$emit('ok', values)
                this.handleCancel()
              } else {
                this.$message.error('新增失败') // + res.message
              }
            }).finally((res) => {
              this.confirmLoading = false
            })
          } else {
            this.confirmLoading = false
          }
        })
      },
      handleCancel() {
        this.form.resetFields()
        this.columnInfo=[];
        this.visible = false
      }
    }
  }
</script>
