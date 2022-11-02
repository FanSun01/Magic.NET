<template>
  <a-modal
    :title="'预览表单:'+name"
    :width="900"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
    :destroyOnClose="true"
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
          <a-input v-decorator="['fields']" />
        </a-form-item>
        <a-form-item v-show="webId == 'kfp'" v-if="frmType == 0">
          <k-form-build :value="jsonData" ref="kfp"/>
        </a-form-item>
        <a-form-item v-else >
          <component :value="jsonData" :is="webId" ref="cfp"></component>
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import 'k-form-design/styles/k-form-design.less'
  // 批量引用
  const ctx = require.context('@/views/flowCenter/custom/', true, /\.vue$/)
  const routes = {};
  ctx.keys().forEach(key => {
      const name = key.split('/')[1].split('.')[0];
      routes[name] = ctx(key).default || ctx(key);
  });
  export default {
    components: {
       ...routes
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
        frmType: 0,
        formLoading: true,
        webId: null,
        jsonData: {},
        name: null,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法
      edit (record) {
        this.visible = true
        this.formLoading = false
        this.name = record.name
        this.frmType = record.frmType
        this.webId = record.webId
        this.jsonData = JSON.parse(record.content);
        if (record.frmType == 0) {
          this.webId = 'kfp'
        }
        setTimeout(() => {
          this.form.setFieldsValue(
            {
              id: record.id,
              name: record.name,
              content: record.content,
              contentParse: record.contentParse,
              contentData: record.contentData,
              fields: record.fields
            }
          )
        }, 100)
      },
      getPreviewData() {
        // 使用getData函数获取数据
        const that = this
        var webId = that.webId
        if(webId!='kfp')
        {
          webId='cfp'
        }
        that.$refs[webId].getData().then(values => {
          that.$message.success('验证通过，' + JSON.stringify(values))
        }).catch(() => {
          that.$message.error('验证未通过，获取失败')
        })
      },
      handleSubmit () {
        this.confirmLoading = true
        this.getPreviewData();
        this.confirmLoading = false
      },
      handleCancel () {
        this.form.resetFields()
        this.visible = false
      }
    }
  }
</script>
