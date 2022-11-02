<template>
  <a-modal
    :title="'申请流程:'+schemeName"
    :width="900"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
    :destroyOnClose="true"
  >
    <a-spin :spinning="formLoading">
      <x-card>
        <div slot="content" class="table-page-search-wrapper">
          <a-form layout="inline">
            <a-form-item
              label="下一步审核人员"
              :labelCol="labelCol"
              :wrapperCol="wrapperCol"
              has-feedback
            >
              <a-col :md="18" :sm="18">
                <a-input :disabled="true" placeholder="请选择下一步审核人员" v-model="nextMakerName" />
              </a-col>
              <a-col v-show="nextNodeDesignateType=='RUNTIME_SPECIAL_USER'||nextNodeDesignateType=='RUNTIME_SPECIAL_ROLE'" :md="6" :sm="6">
                <a-button icon="search" @click="setUser()"/>
              </a-col>
            </a-form-item>
          </a-form>
        </div>
      </x-card> 
      <a-tabs :default-active-key="defaultActive" @change="callback">
          <a-tab-pane key="1" tab="表单信息" :force-Render="true">
            <a-form :form="form">
              <a-form-item v-show="webId == 'kfp'" v-if="frmType == 0">
                <k-form-build :value="jsonData" :config="config" ref='kfp'/>
              </a-form-item>
              <a-form-item v-else >
                <component :is="webId" ref="cfp"></component>
              </a-form-item>
            </a-form>
          </a-tab-pane>
          <a-tab-pane key="2" tab="流程信息" :force-Render="true">
            <a-card :bordered="false">
              <vfd ref="vfd" style="background-color: white;" :needShow="false" :fieldNames="fieldNames"></vfd>
            </a-card>
          </a-tab-pane>
      </a-tabs>    
    </a-spin>
    <user-list-form ref="userListForm" @ok="handleOk"/>
    <role-list-form ref="roleListForm" @ok="handleOk"/>
  </a-modal>
</template>

<script>
  import store from '@/store'
  import { vfd,XCard } from '@/components'
  import 'k-form-design/styles/k-form-design.less'
  import userListForm from '@/views/system/user/userListForm'
  import roleListForm from '@/views/system/role/roleListForm'
  import { getFlcFlowscheme} from '@/api/modular/flowCenter/flowManage'
  import { flowinstanceAdd } from '@/api/modular/flowCenter/flowinstanceManage'
  //批量引用
  const ctx = require.context('@/views/flowCenter/custom/', true, /\.vue$/)
  const routes = {};
  ctx.keys().forEach(key=>{
      const name = key.split("/")[1].split(".")[0];
      routes[name] = ctx(key).default || ctx(key);
    
  });
  export default {
    components: {
      ...routes,
      vfd,
      XCard,
      userListForm,
      roleListForm
    },
    data () {
      return {
        config: {
          //uploadFile: process.env.VUE_APP_API_BASE_URL+ 'sysFileInfo/upload', // 上传文件地址
          //uploadImage: process.env.VUE_APP_API_BASE_URL+ 'sysFileInfo/upload', // 上传图片地址
          uploadFileHeaders: { Authorization: 'Bearer '+ store.getters.token }, // 上传文件请求头部
          uploadImageHeaders: { Authorization: 'Bearer '+ store.getters.token } // 上传图片请求头部
        },
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 }
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 15 }
        },
        defaultActive:1,
        visible: false,
        confirmLoading: false,
        formLoading: true,
        jsonData:{},
        frmType:0,
        fieldNames:[],
        nextNodeDesignates:[],
        nextMakerName:'',
        webId:null,
        nextNodeDesignateType:null,
        schemeName:null,
        schemeContent:null,
        schemeId:null,
        frmId:null,
        form: this.$form.createForm(this)
      }
    },
    methods: {
      // 初始化方法 
      edit (record) {
        this.schemeName = record.schemeName
        this.frmType = record.frmType
        this.webId = record.webId
        if(record.frmType == 0)
        {
          this.webId='kfp'
        }
        this.schemeContent=record.schemeContent
        const queryParam={};
        queryParam.id=record.id
        this.frmId = record.frmId
        this.schemeId = record.id
        getFlcFlowscheme(queryParam).then(res => {
          if (!res.success) {
            return
          }
          if(!res.data.nextNodeDesignateType)
          {
            this.$message.error('请先设计流程') 
            return
          }
          record.nextNodeDesignateType = res.data.nextNodeDesignateType
          record.nextNodeDesignates = res.data.nextNodeDesignates
          record.NextMakerName = res.data.nextMakerName
          this.visible = true
          this.formLoading = false
          this.nextNodeDesignateType = record.nextNodeDesignateType
          switch(this.nextNodeDesignateType)
          {
              case "ALL_USER":
                this.nextMakerName="所有人"
                break
              case "RUNTIME_SPECIAL_USER":
                this.nextMakerName=""
                break
              case "RUNTIME_SPECIAL_ROLE":
                this.nextMakerName="" 
                break
              default:
                this.nextMakerName=record.nextMakerName
                break
          }
          this.jsonData = record.content?JSON.parse(record.content):{};
          setTimeout(() => {
            this.importData(record.schemeContent)
            this.fieldNames=JSON.parse(record.contentParse)     
          }, 100)
        })     
      },
      importData(value){
        if(this.defaultActive == 2 && !!value)
        {
          this.$refs.vfd.loadFlow(value)
        }
        else
        {
          if(!!this.$refs.vfd)
          {
            this.$refs.vfd.clear()
          }
        }
      },
      callback(key)
      {
        this.defaultActive = key
        setTimeout(() => {
          this.importData(this.schemeContent)  
        }, 100)
      },
      getPreviewData(){
        // 使用getData函数获取数据
        const that = this
        var webId=this.webId
        if(webId!='kfp')
        {
          webId='cfp'
        }
        that.$refs[webId].getData().then(values => {
          const frmData = JSON.stringify(values)
          const input = {}
          input.frmId = that.frmId
          input.schemeId = Number(that.schemeId)
          input.frmData = frmData
          input.nextNodeDesignateType= that.nextNodeDesignateType
          input.nextNodeDesignates =that.nextNodeDesignates 
          flowinstanceAdd(input).then((res) => {
            if (res.success) {
              this.$message.success('新增成功')
              this.$emit('ok', values)
              this.handleCancel()
              if(this.webId=='kfp')
              {
                this.$refs['kfp'].reset()
              } 
            } else {
              this.$message.error('新增失败：' + res.message)
            }
          })  
        }).catch(() => {
          that.$message.error('验证未通过，获取失败') 
        })
      },
      setUser()
      {
        if(this.nextNodeDesignateType=="RUNTIME_SPECIAL_USER")
        {
            this.$refs.userListForm.userList();
        }  
        else if(this.nextNodeDesignateType=="RUNTIME_SPECIAL_ROLE")
        {
            this.$refs.roleListForm.roleList();
        }  
      },
      //确认回调
      handleOk(record) {
        const that = this;
				if(!!record)
				{
					const nodeDesignateData=[];
					const nodeDesignateName=[];
					record.forEach(item => {
						nodeDesignateData.push(item.id.toString());
						nodeDesignateName.push(item.name);
					});

					if(nodeDesignateName.length>0)
					{
						that.nextMakerName = nodeDesignateName.join(',');
						that.nextNodeDesignates = nodeDesignateData;
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
        if(!!this.$refs.vfd)
        {        
          this.$refs.vfd.clear()
        }
      }
    }
  }
</script>
