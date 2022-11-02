<template>
  <a-modal
    title="编辑流程"
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
        <a-form-item
          label="机构"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-tree-select
            v-decorator="['orgId']"
            style="width: 100%"
            :dropdownStyle="{ maxHeight: '300px', overflow: 'auto' }"
            :treeData="orgTree"
            placeholder="请选择机构"
            treeDefaultExpandAll
            @change="e => initrOrgName(e)"
          >
            <span slot="title" slot-scope="{ id }">{{ id }}</span>
          </a-tree-select>
        </a-form-item>
        <a-form-item
          label="表单"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-select
            style="width: 100%"
            placeholder="请选择表单"
            v-decorator="['frmId', {rules: [{ required: true, message: '请选择表单！' }]}]">
            <a-select-option
              v-for="(item,index) in formData"
              :key="index"
              :value="item.id">{{ item.name }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item
          label="流程编号"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-input placeholder="请输入流程编号" v-decorator="['schemeCode', {rules: [{required: true, message: '请输入流程名称！'}]}]" />
        </a-form-item>
        <a-form-item
          label="流程名称"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-input placeholder="请输入流程名称" v-decorator="['schemeName', {rules: [{required: true, message: '请输入流程名称！'}]}]" />
        </a-form-item>
        
        <a-form-item
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          label="排序"
        >
          <a-input-number placeholder="请输入排序" style="width: 100%" v-decorator="['sort', { initialValue: 100 }]" :min="1" :max="1000" />
        </a-form-item>

        <a-form-item
          label="备注"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-textarea :rows="4" placeholder="请输入备注" v-decorator="['remark']"></a-textarea>
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import { getOrgTree, getOrgList } from '@/api/modular/system/orgManage'
  import { flcFlowschemeEdit } from '@/api/modular/flowCenter/flowManage'
  import { getFormList } from '@/api/modular/flowCenter/formManage'
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
        orgTree: [],
        selfForms: [],
        visible: false,
        confirmLoading: false,
        formLoading: true,
        webIdShow:false,
        formData:[],
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法
      edit (record) {
        this.visible = true
        this.orgId = record.orgId
        this.getOrgDate ()
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id: record.id,
              schemeCode: record.schemeCode,
              schemeName: record.schemeName,
              frmId: record.frmId,
              orgId: !!record.orgId&&record.orgId!=0?record.orgId:null,
              sort: record.sort,
              remark: record.remark
            }
          )
        }, 100)
      },
      /**
       * 获取机构树，并加载于流程中
       */
      getOrgDate () {
          this.formLoading = false
        getOrgTree().then((res) => {
          this.orgTree = res.data
        })
        getOrgList().then((res) => {
          this.orgList = res.data
        })
        var data={}
        data.orgId=this.orgId
        getFormList(data).then((res)=>{
          this.formData = res.data
        })
      },
      /**
       * 选择树机构，初始化机构名称于流程中
       */
      initrOrgName (value) {
        this.form.getFieldDecorator('sysEmpParam.orgName', { initialValue: this.orgList.find(item => value === item.id).name })
        var data={}
        data.orgId = value
        getFormList(data).then((res)=>{
          this.formData = res.data
        })
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              frmId: null,
            }
          )
        }, 100)
      },
      /**
       * 获取自定义流程，并加载于流程中
       */
      getSelfForms () {
        this.selfForms=[]
      },

      handleSubmit () {
        const { form: { validateFields } } = this
        this.confirmLoading = true
        validateFields((errors, values) => {
          if (!errors) {
            flcFlowschemeEdit(values).then((res) => {
              if (res.success) {
                this.$message.success('编辑成功')
                this.visible = false
                this.confirmLoading = false
                this.$emit('ok', values)
              } else {
                this.$message.error('编辑失败：' + res.message)
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
