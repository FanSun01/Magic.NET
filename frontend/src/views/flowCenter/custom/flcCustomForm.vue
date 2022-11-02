<template>
    <a-spin :spinning="formLoading">
      <a-form :form="form">
        <a-form-item v-show="false">
          <a-input v-decorator="['id']" />
        </a-form-item>
        <a-form-item
          label="名称"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-input placeholder="请输入名称" :disabled="disabled" v-decorator="['name', {rules: [{required: true, message: '请输入表单名称！'}]}]" />
        </a-form-item>
        <a-form-item
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          label="排序"
        >
          <a-input-number placeholder="请输入排序" :disabled="disabled" style="width: 100%" v-decorator="['sort', { initialValue: 100 }]" :min="1" :max="1000" />
        </a-form-item>

        <a-form-item
          label="备注"
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          has-feedback
        >
          <a-textarea :rows="4" placeholder="请输入备注" :disabled="disabled" v-decorator="['remark']"></a-textarea>
        </a-form-item>
      </a-form>
    </a-spin>
</template>

<script>
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
        name : null,
        visible: false,
        confirmLoading: false,
        formLoading: false,
        disabled:false,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法
      edit (record) {
        this.formLoading = false
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id:record.id,
              name: record.name,
              sort: record.sort,
              remark: record.remark,
            }
          )
        }, 100)
      },
      setData(record)
      {
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id:record.id,
              name: record.name,
              sort: record.sort,
              remark: record.remark,
            }
          )
        }, 100)
      },
      disable(record)
      {
        this.disabled = true;
      },
      getData () {
        return new Promise((resolve, reject) => {
          try {
            const { form: { validateFields } } = this
            validateFields((errors, values) => {
              if (!errors) {
                resolve(values);
              } else {
                reject(errors);
              }
            })
          } catch (err) {
            reject(err);
          }
        });
      },
    }
  }
</script>
