<template>
  <a-modal title="编辑数据列" :width="900" :visible="visible" :confirmLoading="confirmLoading" @ok="handleSubmit"
    @cancel="handleCancel">
    <a-spin :spinning="confirmLoading">
      <a-divider orientation="left">数据列信息</a-divider>
      <a-form :form="form">
        <a-form-item label="列名" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input placeholder="请输入列名" v-decorator="['dbColumnName', { rules: [{ required: true, message: '请输入列名！' }] }]" />
        </a-form-item>
        <a-form-item label="描述" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input placeholder="请输入描述" style="width: 100%"
            v-decorator="['columnDescription', { rules: [{ required: true, message: '请输入描述！' }] }]" />
        </a-form-item>
        <a-form-item label="主键" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-select v-decorator="['isPrimarykey', { rules: [{ required: true, message: '请选择是否为主键' }] }]"
            key="isPrimarykey" style="width: 100%" placeholder="请选择" has-feedback
            @change="e => primarykeyHandleChange(e)">
            <a-select-option v-for="(item, index) in selectData" :key="index" :value="item.value">{{ item.text }}
            </a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="自增" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-select :disabled="enabledIsIdentity"
            v-decorator="['isIdentity', { rules: [{ required: true, message: '请选择是否自增' }] }]" key="isIdentity"
            style="width: 100%" placeholder="请选择" has-feedback>
            <a-select-option v-for="(item, index) in selectData" :key="index" :value="item.value">{{ item.text }}
            </a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="可空" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-select :disabled="enabledIsNullabled"
            v-decorator="['isNullable', { rules: [{ required: true, message: '请选择是否可空' }] }]" key="isNullable"
            style="width: 100%" placeholder="请选择" has-feedback>
            <a-select-option v-for="(item, index) in selectData" :key="index" :value="item.value">{{ item.text }}
            </a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="类型" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-select v-decorator="['dataType', { rules: [{ required: true, message: '请选择类型' }] }]" key="dataType"
            style="width: 100%" placeholder="请选择" has-feedback @change="e => dataTypeHandleChange(e)">
            <a-select-option v-for="(item, index) in dataTypeSelectData" :key="index" :value="item.value">
              {{ item.value }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="长度" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input :disabled="!hasLength" placeholder="请输入长度" v-decorator="['length', validateLengthRule]" />
        </a-form-item>
        <a-form-item label="保留小数" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback>
          <a-input :disabled="!hasDecimalDigits" placeholder="请输入位数" v-decorator="['decimalDigits']" />
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
import {
  columnAdd
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
      selectData: [{
        text: '是',
        value: 1
      }, {
        text: '否',
        value: 0
      }],
      hasLength: true,
      hasDecimalDigits: true,
      enabledIsNullabled: false,
      enabledIsIdentity: true,
      tableName: '',
      validateLengthRule: {
        rules: [
          {required: this.lengthIsRequire, message: '请输入字段长度'},
          {
            validator: (rule, value, cbfn) => {
              const form = this.form;
              let dataType = form.getFieldValue('dataType');
              if((dataType=='varchar' || dataType =='nvarchar') && !value){
                cbfn('请输入长度');
                return false;
              }
              if ((dataType=="varchar" || dataType=="nvarchar") && value<=0) {
                cbfn('长度不能小于0')
              }
              cbfn()
            },
          },
        ]
      }
    }
  },
  methods: {
    dataTypeHandleChange(value) {
      let type = this.dataTypeSelectData.find(item => item.value == value);
      if (type) {
        this.hasLength = type.hasLength
        this.hasDecimalDigits = type.hasDecimalDigits
        if (!this.hasLength) {
          this.form.setFieldsValue({
            length: 0
          });
        }
        if (!this.hasDecimalDigits) {
          this.form.setFieldsValue({
            decimalDigits: 0
          });
        }
      }
    },
    primarykeyHandleChange(value) {
      if (value == 1) {
        this.enabledIsNullabled = true;
        this.enabledIsIdentity = false;
        this.form.setFieldsValue({
          isNullable: 0
        });
      } else {
        this.enabledIsNullabled = false;
        this.enabledIsIdentity = true;
        this.form.setFieldsValue({
          isIdentity: 0
        });
      }
    },
    // 初始化方法
    add(tableName) {
      this.tableName = tableName;
      this.visible = true
    },
    handleSubmit() {
      const {
        form: {
          validateFields
        }
      } = this
      this.confirmLoading = true
      validateFields((errors, values) => {
        if (!errors) {
          values["tableName"] = this.tableName;
          columnAdd(values).then((res) => {
            if (res.success) {
              this.$message.success('新增成功')
              this.confirmLoading = false
              this.$emit('ok', values)
              this.handleCancel()
            } else {
              this.$message.error('新增失败') //  + res.message
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
      this.visible = false
    }
  }
}
</script>
