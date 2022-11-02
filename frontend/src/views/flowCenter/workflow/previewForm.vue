<template>
  <a-modal
    :title="'查看申请:'+customName"
    :width="900"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
  >
    <a-spin :spinning="formLoading">
      <x-card>
        <div slot="content" class="table-page-search-wrapper">
          <a-form layout="inline">
            <a-form-item v-if="!!nextMakerName"
              label="当前审核人员"
              :labelCol="labelCol"
              :wrapperCol="wrapperCol"
              has-feedback
            >
              <a-col :md="18" :sm="18">
                <a-input :disabled="true" placeholder="当前审核人员" v-model="nextMakerName" />
              </a-col>
            </a-form-item>
          </a-form>
        </div>
      </x-card>       
      <a-tabs :default-active-key="defaultActive" @change="callback">
          <a-tab-pane key="1" tab="表单信息" :force-Render="true">
            <a-form :form="form">
              <a-form-item v-show="webId == 'kfp'" v-if="frmType == 0">
                <k-form-build :value="jsonData" ref='kfp'/>
              </a-form-item>
              <a-form-item v-else >
                <component :is="webId" ref="cfp"></component>
              </a-form-item>
            </a-form>
          </a-tab-pane>
          <a-tab-pane key="2" tab="流程信息" :force-Render="true">
            <a-card :bordered="false">
              <vfd ref="vfd" style="background-color: white;" :needShow="false" :activityId="activityId" :fieldNames="fieldNames"></vfd>
            </a-card>
          </a-tab-pane>
          <a-tab-pane key="3" tab="流转信息" :force-Render="true">
            <a-table
              :columns="columns"
              :data-source="hisList"
            >
            </a-table>
          </a-tab-pane>
      </a-tabs>     
    </a-spin>
  </a-modal>
</template>

<script>
  import { vfd,XCard } from '@/components'
  import 'k-form-design/styles/k-form-design.less'
  import { getFlowinstance } from '@/api/modular/flowCenter/flowinstanceManage'
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
      XCard
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
        defaultActive:1,
        visible: false,
        confirmLoading: false,
        formLoading: true,
        jsonData:{},
        frmData:{},
        frmContentData:[],
        frmType:0,
        fieldNames:[],
        nextNodeDesignates:'',
        nextMakerName:'',
        webId:null,
        nextNodeDesignateType:null,
        customName:null,
        schemeContent:null,
        activityId:null,
        schemeId:null,
        frmId:null,
        form: this.$form.createForm(this),
                // 表头
        columns: [
          {
            title: '操作信息',
            dataIndex: 'content'
          },
          {
            title: '操作时间',
            dataIndex: 'createdTime'
          },
          {
            title: '操作人',
            dataIndex: 'createdUserName'
          }
        ],
        hisList:[]
      }
    },
    methods: {
      // 初始化方法 
      edit (record) {
        this.customName = record.customName
        this.frmType = record.frmType
        this.schemeContent=record.schemeContent
        const queryParam={};
        queryParam.id=record.id
        this.frmId = record.frmId
        this.schemeId = record.id
        this.activityId = record.activityId
        getFlowinstance(queryParam).then(res => {
          if (!res.success) {
            return
          }
          this.webId = res.data.webId
          if(record.frmType == 0)
          {
            this.webId='kfp'
          }
          record.nextNodeDesignateType = res.data.currentNodeDesignateType
          record.nextNodeDesignates = res.data.nextNodeDesignates
          record.nextMakerName = res.data.currentMakerName
          this.visible = true
          this.formLoading = false
          this.nextNodeDesignateType = record.nextNodeDesignateType
          this.hisList = res.data.hisList
          switch(this.nextNodeDesignateType)
          {
              case "ALL_USER":
                this.nextMakerName="所有人"
                break
              default:
                this.nextMakerName=record.nextMakerName
                break
          }
          this.jsonData =record.frmContent?JSON.parse(record.frmContent): {};
          this.frmData = JSON.parse(record.frmData);
          this.frmContentData = record.frmContentData.split(",");
          setTimeout(() => {
            this.importData()
            this.fieldNames=JSON.parse(record.frmContentParse)     
          }, 100)
        })     
      },
      importData(){
        if(this.defaultActive == 2)
        {
          if(!!this.schemeContent)
          {
            if(!!this.$refs.vfd)
            {
              this.$refs.vfd.loadFlow(this.schemeContent)
            }
            else
            {
              setTimeout(() => {
                this.$refs.vfd.loadFlow(this.schemeContent);  
              }, 100)
            }
          }
          else{
            this.$refs.vfd.clear()
          }
        }
        else if(this.defaultActive == 1)
        {
          if(!!this.$refs.vfd)
          {
            this.$refs.vfd.clear()
          }
          if(this.webId=='kfp')
          {
            if (!!this.$refs.kfp)
            {
              this.$refs.kfp.setData(this.frmData);
              this.$refs.kfp.disable(this.frmContentData);
            }
            else
            {
              setTimeout(() => {
                this.$refs.kfp.setData(this.frmData);  
                this.$refs.kfp.disable(this.frmContentData); 
              }, 100)
            }
          } 
          else      
          {
            if (!!this.$refs.cfp)
            {
              this.$refs.cfp.setData(this.frmData);
              this.$refs.cfp.disable(this.frmContentData); 
            }
            else
            {
              setTimeout(() => {
                this.$refs.cfp.setData(this.frmData);  
                this.$refs.cfp.disable(this.frmContentData); 
              }, 100)
            }
          }
        }
        else{
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
          this.importData()  
        }, 100)
      },
      handleSubmit () {
        this.handleCancel ()
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
