<template>
  <a-modal
    :title="'设计表单:'+name"
    :width="900"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
  >
    <a-spin :spinning="formLoading">
      <a-form :form="form">
        <a-form-item v-show="false">
          <a-input v-decorator="['id']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['name']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['content']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['contentData']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['contentParse']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['fields']" />
        </a-form-item>
        <a-form-item>
          <k-form-design :showHead="false" :toolbars="['reset', 'importJson','exportJson', 'preview','exportCode']" style="background-color: white;" ref='kfd' />
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import 'k-form-design/styles/k-form-design.less'
  import { flcFormEdit } from '@/api/modular/flowCenter/formManage'
  export default {
    data () {
      return {
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 }
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 15 }
        },
        visible: false,
        confirmLoading: false,
        formLoading: true,
        name:null,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法 
      edit (record) {
        this.visible = true
        this.formLoading = false
        this.name=record.name
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id: record.id,
              name: record.name,
              content: record.content,
              contentParse: record.contentParse,
              contentData: record.contentData,
              fields:record.fields
            }
          )
          this.importData(record.content)
        }, 100)
      },
      importData(value){
        if(!!value)
        {
          this.$refs.kfd.handleSetData(JSON.parse(value));
        }
      },
      getDesignData(){
        const kfd = this.$refs.kfd
        const fieldData= kfd.getFieldSchema()
        const fields = []
        const fieldsParse = []
        fieldData.forEach(item=>{
          const tempData={}
          tempData.id=item.key
          tempData.name=item.label
          fieldsParse.push(tempData)
          fields.push(item.key)
        })
        this.content = fields.length>0?JSON.stringify(kfd.getValue()):null;
        this.contentData = fields.length>0?fields.join(","):null
        this.contentParse = fieldsParse.length>0?JSON.stringify(fieldsParse):null
        this.fields = fieldData.length
        this.form.setFieldsValue(
        {
          content: this.content,
          contentData: this.contentData,
          contentParse: this.contentParse,
          fields:this.fields
        })
      },
      handleSubmit () {
        this.confirmLoading = true
        this.getDesignData();
        const { form: { validateFields } } = this
        validateFields((errors, values) => {
          if (!errors) {
            flcFormEdit(values).then((res) => {
              if (res.success) {
                this.$message.success('设计成功')
                this.visible = false
                this.confirmLoading = false
                this.$emit('ok', values)
                this.form.resetFields()
              } else {
                this.$message.error('设计失败：' + res.message)
              }
            }).finally((res) => {
              this.confirmLoading = false
            })
          } else {
            this.confirmLoading = false
          }
        })
      },
      handleCancel () {
        this.form.resetFields()
        this.visible = false
      }
    }
  }
</script>
