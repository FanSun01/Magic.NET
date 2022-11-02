<template>
  <a-modal
    :title="'预览流程:'+schemeName"
    :width="900"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
    :destroyOnClose="true"
  >
    <a-spin :spinning="formLoading">
      <a-tabs :default-active-key="defaultActive" @change="callback">
        <a-tab-pane key="1" tab="表单信息" :force-Render="true">
          <a-form :form="form">
            <a-form-item v-show="false">
              <a-input v-decorator="['id']" />
            </a-form-item>
            <a-form-item v-show="false">
              <a-input v-decorator="['schemeName']" />
            </a-form-item>
            <a-form-item v-show="false">
              <a-input v-decorator="['frmId']" />
            </a-form-item>
            <a-form-item v-show="webId == 'kfp'" v-if="frmType == 0">
              <k-form-build :value="jsonData" ref="kfp"/>
            </a-form-item>
            <a-form-item v-else >
              <component :value="jsonData" :is="webId" ref="cfp"></component>
            </a-form-item>
          </a-form>
        </a-tab-pane>
        <a-tab-pane key="2" tab="流程信息" :force-Render="true">
          <vfd ref="vfd" style="background-color: white;" :needShow="false" :fieldNames="fieldNames"></vfd>
        </a-tab-pane>
      </a-tabs>
    </a-spin>
    <user-list-form ref="userListForm" @ok="handleOk"/>
    <role-list-form ref="roleListForm" @ok="handleOk"/>
  </a-modal>
</template>

<script>
  import { vfd } from '@/components'
  import 'k-form-design/styles/k-form-design.less'
  import userListForm from '@/views/system/user/userListForm'
  import roleListForm from '@/views/system/role/roleListForm'
  import { getFlcFlowscheme } from '@/api/modular/flowCenter/flowManage'
import varyColor from 'webpack-theme-color-replacer/client/varyColor'
  // 批量引用
  const ctx = require.context('@/views/flowCenter/custom/', true, /\.vue$/)
  const routes = {};
  ctx.keys().forEach(key => {
      const name = key.split('/')[1].split('.')[0];
      routes[name] = ctx(key).default || ctx(key);
  });
  export default {
    components: {
      ...routes,
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
        defaultActive: 1,
        visible: false,
        confirmLoading: false,
        formLoading: true,
        jsonData: {},
        frmType: 0,
        fieldNames: [],
        nextNodeDesignates: '',
        nextMakerName: '',
        webId: null,
        nextNodeDesignateType: null,
        schemeName: null,
        schemeContent: null,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法
      edit (record) {
        this.schemeName = record.schemeName
        this.frmType = record.frmType
        this.webId = record.webId
        if (record.frmType == 0) {
          this.webId = 'kfp'
        }
        this.schemeContent = record.schemeContent
        const queryParam = {};
        queryParam.id = record.id
        getFlcFlowscheme(queryParam).then(res => {
          if (!res.success) {
            return
          }
          if (!res.data.nextNodeDesignateType) {
            this.$message.error('请先设计流程')
            return
          }
          record.nextNodeDesignateType = res.data.nextNodeDesignateType
          record.nextNodeDesignates = res.data.nextNodeDesignates
          record.NextMakerName = res.data.nextMakerName
          this.visible = true
          this.formLoading = false
          this.nextNodeDesignateType = record.nextNodeDesignateType
          switch (this.nextNodeDesignateType) {
              case 'ALL_USER':
                this.nextMakerName = '所有人'
                break
              case 'RUNTIME_SPECIAL_USER':
                this.nextMakerName = ''
                break
              case 'RUNTIME_SPECIAL_ROLE':
                this.nextMakerName = ''
                break
              default:
                this.nextMakerName = record.nextMakerName
                break
          }
          this.jsonData =!!record.content?JSON.parse(record.content):{};
          setTimeout(() => {
            this.form.setFieldsValue(
              {
                id: record.id,
                schemeName: record.schemeName,
                frmId: record.frmId
              }
            )
            this.importData(record.schemeContent)
            this.fieldNames = JSON.parse(record.contentParse)
          }, 100)
        })
        console.log(this.$refs);
      },
      importData(value) {
        if (this.defaultActive == 2 && !!value) {
          this.$refs.vfd.loadFlow(value)
        } else {
          if (this.$refs.vfd) {
            this.$refs.vfd.clear()
          }
        }
      },
      callback(key) {
        this.defaultActive = key
        setTimeout(() => {
          this.importData(this.schemeContent)
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
          that.visible = false
          if (that.$refs.vfd) {
            that.$refs.vfd.clear()
          }
        }).catch(() => {
          that.$message.error('验证未通过，获取失败')
        })
      },
      setUser() {
        if (this.nextNodeDesignateType == 'RUNTIME_SPECIAL_USER') {
            this.$refs.userListForm.userList();
        } else if (this.nextNodeDesignateType == 'RUNTIME_SPECIAL_ROLE') {
            this.$refs.roleListForm.roleList();
        }
      },
      // 确认回调
      handleOk(value) {
        const that = this;
				if (record) {
					const nodeDesignateData = [];
					const nodeDesignateName = [];
					record.forEach(item => {
						nodeDesignateData.push(item.id);
						nodeDesignateName.push(item.name);
					});

					if (nodeDesignateName.length > 0) {
						that.nextMakerName = nodeDesignateName.join(',');
						that.nextNodeDesignates = nodeDesignateData.join(',');
					}
				}
      },
      handleSubmit () {
        this.confirmLoading = true
        this.getPreviewData();
        this.confirmLoading = false
      },
      handleCancel () {
        this.form.resetFields()
        this.visible = false
        if (this.$refs.vfd) {
          this.$refs.vfd.clear()
        }
      }
    }
  }
</script>
