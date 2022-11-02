<template>
  <a-modal
    title="上传文件"
    :width="600"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
    :destroyOnClose="true">
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
        <a-form-item v-show="false">
          <a-input v-decorator="['pId']"/>
        </a-form-item>
        <a-form-item label="上传文件" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-upload
            v-if="uploadReset"
            :fileList="fileList"
            :customRequest="customRequest"
            :remove="removeFile"
            :multiple="true"
            :showUploadList="true"
            name="file"
            v-decorator="['file']">
            <a-button icon="upload" :loading="uploading" :disabled="uploading">上传</a-button>
          </a-upload>
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import {
    DocumentUpload
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
        pId: 0,
        visible: false,
        confirmLoading: false,
        form: this.$form.createForm(this),
        uploadReset: true,
        uploading: false,
        fileList: []
      }
    },
    methods: {
      // 初始化方法
      upload(pId) {
        this.visible = true
        this.uploadReset = true
        this.pId = pId
        setTimeout(() => {
          this.form.setFieldsValue({
            pId: pId
          })
        }, 100)
      },
      /**
       * 提交表单
       */
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
              if (typeof (values[key]) === 'object') {
                values[key] = JSON.stringify(values[key])
              }
            }
            // 创建上传参数
            const formData = new FormData()
            formData.append('pId', values.pId)
            this.fileList.forEach(file => {
              formData.append('files', file)
            })
            // 调上传接口
            DocumentUpload(formData).then((res) => {
              if (res.success) {
                this.$message.success('上传成功')
                this.confirmLoading = false
                this.$emit('ok', values)
                this.handleCancel()
              } else {
                console.log(res.message)
                this.$message.error('上传失败:' + res.message)
              }
            }).finally((res) => {
              this.confirmLoading = false
            })
          } else {
            this.confirmLoading = false
          }
        })
      },
      /**
       * 自定义文件上传
       * 将form中的数据用append方法放入formData对象中
       * @param options 上传的文件
       */
      customRequest(options) {
        this.uploading = true
        options.file.status = 'done'
        this.fileList.push(options.file)
        this.uploading = false
      },
      /**
       * 删除文件时,删除formData,form中对应项,并重置form中对文件上传的校验
       */
      removeFile(file) {
        this.$confirm({
          title: '提示',
          content: '真的要取消上传 "' + file.name + '" 吗 ?',
          okText: '确定',
          cancelText: '取消',
          onOk: () => {
            this.fileList = this.fileList.filter(item => item.uid !== file.uid)
          }
        })
      },
      handleCancel() {
        this.form.resetFields()
        this.uploadReset = false // 重新渲染upload组件
        this.fileList = [] // 置空已上传文件列表
        this.visible = false
      }
    }
  }
</script>
