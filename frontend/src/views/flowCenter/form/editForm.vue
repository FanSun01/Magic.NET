<template>
  <a-modal
    title="编辑表单"
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
          label="表单名称"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-input placeholder="请输入表单名称" v-decorator="['name', {rules: [{required: true, message: '请输入表单名称！'}]}]" />
        </a-form-item>

        <a-form-item
          label="表单类型"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-select
            style="width: 100%"
            placeholder="请选择表单类型"
            @change="e => handleChange(e)"
            has-feedback
            v-decorator="['frmType', {rules: [{required: true, message: '请选择表单类型！'}]}]"
          >
            <a-select-option v-for="(item,indexs) in formTypeList" :key="indexs" :value="item.id">{{ item.name }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item
          label="自定义表单"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
          v-show="webIdShow"
        >
          <a-input placeholder="请输入自定义表单路径" v-decorator="['webId']" />
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
        orgTree: [],
        selfForms: [],
        frmType:0,
        formTypeList:[{id:0,name:"动态表单"},{id:1,name:"自定义表单"}],
        visible: false,
        confirmLoading: false,
        formLoading: true,
        webIdShow:false,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法
      edit (record) {
        this.visible = true
        this.getOrgDate ()
        this.handleChange(record.frmType)
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id: record.id,
              name: record.name,
              frmType: record.frmType,
              webId: record.webId,
              orgId: !!record.orgId&&record.orgId!=0?record.orgId:null,
              sort: record.sort,
              active: record.active,
              remark: record.remark
            }
          )
        }, 100)
      },
      /**
       * 选择子表单单项触发
       */
      handleChange (value) {
        if (value) {
          this.frmType = value
        }
        this.webIdShow = !!value?true:false;
      },
      /**
       * 获取机构树，并加载于表单中
       */
      getOrgDate () {
          this.formLoading = false
        getOrgTree().then((res) => {
          this.orgTree = res.data
        })
        getOrgList().then((res) => {
          this.orgList = res.data
        })
      },
      /**
       * 选择树机构，初始化机构名称于表单中
       */
      initrOrgName (value) {
        this.form.getFieldDecorator('sysEmpParam.orgName', { initialValue: this.orgList.find(item => value === item.id).name })
      },
      /**
       * 获取自定义表单，并加载于表单中
       */
      getSelfForms () {
        this.selfForms=[]
      },

      handleSubmit () {
        const { form: { validateFields } } = this
        this.confirmLoading = true
        validateFields((errors, values) => {
          if (!errors) {
            flcFormEdit(values).then((res) => {
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
