<template>
  <a-modal
    :title="'设计流程:'+schemeName"
    :width="1500"
    :height="100"
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
          <a-input v-decorator="['schemeName']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['contentParse']" />
        </a-form-item>
        <a-form-item v-show="false">
          <a-input v-decorator="['schemeContent',{rules: [{ required: true}]}]" />
        </a-form-item>
        <a-form-item>
          <vfd ref="vfd" style="background-color: white;" :needShow="true" :fieldNames="fieldNames" @openUser="openUser()" @openRole="openRole()"></vfd>
        </a-form-item>
      </a-form>
    </a-spin>
    <user-list-form ref="userListForm" @ok="handleOkUser"/>
    <role-list-form ref="roleListForm" @ok="handleOkRole"/>
  </a-modal>
</template>

<script>
  import { vfd } from '@/components'
  import { flcFlowschemeEdit } from '@/api/modular/flowCenter/flowManage'
  import userListForm from '@/views/system/user/userListForm'
  import roleListForm from '@/views/system/role/roleListForm'
  export default {
    components: {
      vfd,
      userListForm,
      roleListForm
    },
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
        schemeName:null,
        fieldNames:[],
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法 
      edit (record) {

        this.visible = true
        this.formLoading = false
        this.schemeName=record.schemeName
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id: record.id,
              schemeName: record.schemeName,
              schemeContent: record.schemeContent,
              contentParse: record.contentParse
            }
          )
          this.fieldNames=JSON.parse(record.contentParse)
          this.importData(record.schemeContent)
        }, 100)
      },
      importData(value){
        if(!!value)
        {
          this.$refs.vfd.loadFlow(value)
        }
        else
        {
          this.$refs.vfd.clear()
        }  
      },
      getDesignData(){
        const vfd = this.$refs.vfd
        const flowData=vfd.saveFlow()
        this.schemeContent = flowData
        this.form.setFieldsValue(
        {
          schemeContent: this.schemeContent,
        })
      },
      //选择用户界面
      openUser(value)
      {
        this.$refs.userListForm.userList(value);
      },
      //选择角色界面
      openRole(value) {
        this.$refs.roleListForm.roleList(value);
      },  
      //用户确认回调 
      handleOkUser(value) {
        this.$refs.vfd.setFlowAttrForm(value);
      },
      //角色确认回调
      handleOkRole(value) {
        this.$refs.vfd.setFlowAttrForm(value);
      },
      handleSubmit () {
        this.confirmLoading = true
        this.getDesignData();
        const { form: { validateFields } } = this
        validateFields((errors, values) => {
          if (!errors) {
            flcFlowschemeEdit(values).then((res) => {
              if (res.success) {
                this.$message.success('设计成功')
                this.visible = false
                this.confirmLoading = false
                this.$emit('ok', values)
                this.form.resetFields()
                this.$refs.vfd.clear()
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
        this.$refs.vfd.clear()
        this.visible = false
        this.$refs.vfd.clear()
      }
    }
  }
</script>
