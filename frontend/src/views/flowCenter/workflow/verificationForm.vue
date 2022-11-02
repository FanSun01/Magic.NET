<template>
  <a-modal
    :title="'处理申请:'+customName"
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
            <a-col :md="12" :sm="12">
              <a-form-item
                label="审核结果"
                :labelCol="labelCol"
                :wrapperCol="wrapperCol"
                has-feedback
              >
                <a-select placeholder="审核结果"
                v-model="verificationFinally" @change="e => conditionChange(e)">
                  <a-select-option
                  v-for="(condition,index) in conditions "
                  :key="index"
                  :value="condition.id">{{ condition.name }}</a-select-option>
                </a-select>
              </a-form-item>
            </a-col>
            <a-col :md="12" :sm="12">
              <a-form-item
                label="审核意见"
                :labelCol="labelCol"
                :wrapperCol="wrapperCol"
                has-feedback
              >
                <a-input placeholder="审核意见" v-model="verificationOpinion" />
              </a-form-item>
            </a-col>
            <a-form-item v-if="!!nextMakerName &&verificationFinally=='1'"
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
    <user-list-form ref="userListForm" @ok="handleOk"/>
    <role-list-form ref="roleListForm" @ok="handleOk"/>
  </a-modal>
</template>

<script>
  import { vfd,XCard } from '@/components'
  import 'k-form-design/styles/k-form-design.less'
  import userListForm from '@/views/system/user/userListForm'
  import roleListForm from '@/views/system/role/roleListForm'
  import { flowinstanceVerification,getFlowinstance } from '@/api/modular/flowCenter/flowinstanceManage'
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
        nextNodeDesignates:[],
        nextMakerName:'',
        webId:null,
        nextNodeDesignateType:null,
        customName:null,
        schemeContent:null,
        activityId:null,
        schemeId:null,
        frmId:null,
        form: this.$form.createForm(this),
        verificationFinally:"1",
        verificationOpinion:null,
        flowInstanceId:null,
        conditions:[{id:'1',name:'同意'},
				{id:'2',name:'不同意'},{id:'3',name:'驳回'}],	
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
        this.flowInstanceId=record.id
        this.frmId = record.frmId
        this.schemeId = record.id
        this.activityId = record.activityId
        this.nodeRejectStep = record.nodeRejectStep
        this.nodeRejectType = record.nodeRejectType
        getFlowinstance(queryParam).then(res => {
          if (!res.success) {
            return
          }
          this.webId = res.data.webId
          if(record.frmType == 0)
          {
            this.webId='kfp'
          }
          record.nextNodeDesignateType = res.data.nextNodeDesignateType
          record.nextNodeDesignates = res.data.nextNodeDesignates
          record.nextMakerName = res.data.nextMakerName
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
      conditionChange (e) {
				const that = this;
				this.condition = e;
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
      callback(key)
      {
        this.defaultActive = key
        setTimeout(() => {
          this.importData()  
        }, 100)
      },
      handleSubmit () {
        const that = this
        const input = {}  
        that.confirmLoading = true
        input.flowInstanceId = that.flowInstanceId
        input.verificationFinally = that.verificationFinally
        input.verificationOpinion = that.verificationOpinion
        input.nodeRejectStep = that.nodeRejectStep
        input.nodeRejectType = that.nodeRejectType
        input.nodeDesignateType=that.nextNodeDesignateType
        input.nodeDesignates=that.nextNodeDesignates
        flowinstanceVerification(input).then((res) => {
          if (res.success) {
            this.$message.success('审核成功')
            this.$emit('ok')
            this.handleCancel()
            if(this.webId=='kfp')
            {
              this.$refs['kfp'].reset()
            } 
          } else {
            this.$message.error('审核失败：' + res.message)
          }
        })  
        that.confirmLoading = false
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
