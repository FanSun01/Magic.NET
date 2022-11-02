<template>
  <a-modal title="编辑文档" :width="600" :visible="visible" :confirmLoading="confirmLoading" @ok="handleSubmit"
    @cancel="handleCancel">
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
        <a-form-item v-show="false">
          <a-input v-decorator="['id']" />
        </a-form-item>
        <a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
          <a-input placeholder="请输入名称" v-decorator="['name']" />
        </a-form-item>
        
        <a-form-item label="标签" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
          <a-select style="width: 100%" placeholder="请输入标签" v-decorator="['label']">
            <a-select-option v-for="(item, index) in docLabelData" :key="index" :value="item.code">{{
                        item.name
                      }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="备注" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
          <a-input placeholder="请输入备注" v-decorator="['remark']" />

        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import {
    DocumentEdit
  } from '@/api/modular/system/fileManage/documentManage'
  export default {
    data() {
      return {
        labelCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 6
          }
        },
        wrapperCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 16
          }
        },
        visible: false,
        confirmLoading: false,
        form: this.$form.createForm(this),
        docLabelData: []
      }
    },
    methods: {
      // 初始化方法
      edit(record) {
        this.visible = true
        this.docLabelData = this.$options.filters['dictData']('doc_label')
      setTimeout(() => {
        this.form.setFieldsValue({
          id: record.id,
          name: record.name.split(".")[0],
          label: record.label,
          remark: record.remark
        })
      }, 100)
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
          for (const key in values) {
            if (typeof(values[key]) === 'object') {
              values[key] = JSON.stringify(values[key])
            }
          }
        
          for (const prop in values) {
            if (values[prop] === 'null') {
              // console.log(values[prop] )
             delete values[prop] 
            }
          }

          DocumentEdit(values).then((res) => {
            if (res.success) {
              this.$message.success('编辑成功')
              this.confirmLoading = false
              this.$emit('ok', values)
              this.handleCancel()
            } else {
              this.$message.error('编辑失败:' + JSON.stringify(res.message)) //  + res.message
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
