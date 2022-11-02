<template>
	<div>
		<a-tabs size="small" defaultActiveKey="flow-attr" :activeKey="activeKey">
			<a-tab-pane key="flow-attr">
				<span slot="tab">
					<a-icon type="cluster" />
					流程属性
				</span>
				<a-form layout="horizontal">
					<a-form-item label="流程id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-input :value="flowData.attr.id" disabled />
					</a-form-item>
				</a-form>
			</a-tab-pane>
			<a-tab-pane key="node-attr">
				<span slot="tab">
					<a-icon type="profile" />
					节点属性
				</span>
				<template v-if="currentSelect.type == 'start round mix'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
					</a-form>
				</template>
				<template v-if="currentSelect.type == 'end round'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
					</a-form>
				</template>
				<template v-if="currentSelect.type == 'node'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
						<a-form-item label="驳回类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select v-model="setInfo.nodeRejectType"  @change="e => nodeRejectTypeChange(e)">
								<a-select-option
								v-for="(item,index) in nodeRejectType"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="会签方式" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select v-model="setInfo.nodeConfluenceType"  @change="e => nodeConfluenceTypeChange(e)">
								<a-select-option
								v-for="(item,index) in nodeConfluenceType"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="回调URL" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="setInfo.thirdPartyUrl " @change="linkThirdPartyUrlChange" />
						</a-form-item>
						<a-form-item label="执行权限" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select :default-value="setInfo.nodeDesignate" v-model="setInfo.nodeDesignate" @change="e => nodeDesignateChange(e)">
								<a-select-option
								v-for="(item,index) in nodeDesignateData"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item  v-show="specialShow" v-if="setInfo.nodeDesignate=='SPECIAL_USER'" label="指定用户" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-col :md="18" :sm="18">
								<a-input disabled="disabled" v-model="specialName" />
							</a-col>
							<a-col :md="6" :sm="6">
								<a-button icon="search" @click="setUser()"/>
							</a-col>
						</a-form-item>
						<a-form-item  v-show="specialShow" v-else label="指定角色" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-col :md="18" :sm="18">
								<a-input disabled="disabled" v-model="specialName" />
							</a-col>
							<a-col :md="6" :sm="6">
								<a-button icon="search" @click="setRole()"/>
							</a-col>
						</a-form-item>
						<a-form-item label="当前部门" v-if="setInfo.nodeDesignate=='SPECIAL_ROLE'" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
 							<a-switch checkedChildren="是" unCheckedChildren="否" v-model="currentDepart" @click="currentDepartChange"/><!-- defaultChecked -->
						</a-form-item>
					</a-form>
				</template>
				<template v-else-if="currentSelect.type == 'fork'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
					</a-form>
				</template>
				<template v-else-if="currentSelect.type == 'join'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
						<a-form-item label="驳回类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select v-model="setInfo.nodeRejectType"  @change="e => nodeRejectTypeChange(e)">
								<a-select-option
								v-for="(item,index) in nodeRejectType"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="会签方式" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select v-model="setInfo.nodeConfluenceType"  @change="e => nodeConfluenceTypeChange(e)">
								<a-select-option
								v-for="(item,index) in nodeConfluenceType"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item label="回调URL" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="setInfo.thirdPartyUrl" @change="linkThirdPartyUrlChange" />
						</a-form-item>
						<a-form-item label="执行权限" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-select :default-value="setInfo.nodeDesignate" v-model="setInfo.nodeDesignate"  @change="e => nodeDesignateChange(e)">
								<a-select-option
								v-for="(item,index) in nodeDesignateData"
								:key="index"
								:value="item.id">{{ item.name }}</a-select-option>
							</a-select>
						</a-form-item>
						<a-form-item  v-show="specialShow" v-if="setInfo.nodeDesignate=='SPECIAL_USER'" label="指定用户" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-col :md="18" :sm="18">
								<a-input disabled="disabled" v-model="specialName" />
							</a-col>
							<a-col :md="6" :sm="6">
								<a-button icon="search" @click="setUser()"/>
							</a-col>
						</a-form-item>
						<a-form-item  v-show="specialShow" v-else label="指定角色" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-col :md="18" :sm="18">
								<a-input disabled="disabled" v-model="specialName" />
							</a-col>
							<a-col :md="6" :sm="6">
								<a-button icon="search" @click="setRole()"/>
							</a-col>
						</a-form-item>
						<a-form-item label="当前部门" v-if="setInfo.nodeDesignate=='SPECIAL_ROLE'"  :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
 							<a-switch checkedChildren="是" unCheckedChildren="否" v-model="currentDepart" @click="currentDepartChange"/><!-- defaultChecked -->
						</a-form-item>
					</a-form>
				</template>
				<template v-else-if="currentSelect.type == 'x-lane' || currentSelect.type == 'y-lane'">
					<a-form layout="horizontal">
						<a-form-item label="类型" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-tag color="purple">{{ currentSelect.type }}</a-tag>
						</a-form-item>
						<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input :value="currentSelect.id" disabled />
						</a-form-item>
						<a-form-item label="名称" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-input placeholder="请输入节点名称" :value="currentSelect.name" @change="nameChange" />
						</a-form-item>
					</a-form>
				</template>
			</a-tab-pane>
			<a-tab-pane key="link-attr">
				<span slot="tab">
					<a-icon type="branches" />
					连线属性
				</span>
				<a-form layout="horizontal">
					<a-form-item label="id" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-input :value="currentSelect.id" disabled />
					</a-form-item>
					<a-form-item label="源节点" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-input :value="currentSelect.sourceId" disabled />
					</a-form-item>
					<a-form-item label="目标节点" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-input :value="currentSelect.targetId" disabled />
					</a-form-item>
					<a-form-item label="文本" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-input :value="currentSelect.label" @change="linkLabelChange" />
					</a-form-item>
					<a-form-item label="添加条件" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
						<a-button icon="plus" @click="addList()"/>
					</a-form-item>
					<div :key="i"  v-for="(item,i) in compares">
						<a-form-item :label="'条件'+i" :label-col="formItemLayout.labelCol" :wrapper-col="formItemLayout.wrapperCol">
							<a-col :md="10" :sm="10">
								<a-select placeholder="关系"
								v-model="compares[i].condition" @change="e => conditionChange(i,e)">
									<a-select-option
									v-for="(condition,index) in conditions "
									:key="index"
									:value="condition.id">{{ condition.name }}</a-select-option>
								</a-select>
							</a-col>
							<a-col :md="10" :sm="10">
								<a-select placeholder="属性"
								v-model="compares[i].fieldName" @change="e => fieldNameChange(i,e)">
									<a-select-option
									v-for="(fieldName,index) in fieldNames "
									:key="index"
									:value="fieldName.id">{{ fieldName.name }}</a-select-option>
								</a-select>
							</a-col>
							<a-col :md="4" :sm="4">		
								<a-button icon="minus" @click="subList(i)" v-if="compares.length>0"/>
							</a-col>
							<a-col :md="10" :sm="10">
							<a-select placeholder="比较"
								v-model="compares[i].operation" @change="e => operationChange(i,e)">
								<a-select-option
									v-for="(operation,index) in operations"
									:key="index"
									:value="operation.id">{{ operation.name }}</a-select-option>
								</a-select>
							</a-col>
							<a-col :md="10" :sm="10" v-if="compares[i].fieldName=='CreatedUserId'||compares[i].fieldName=='CreatedOrgId'">
								<a-tooltip placement="topLeft">
									<span v-if="compares[i].valueName" slot="title">
									{{ compares[i].valueName }}
									</span>
									<template v-else slot="title">
										值
									</template>
									<div>	
										<a-input :disabled="true" v-model="compares[i].valueName" clearable placeholder="值"/>	
									</div>
								</a-tooltip>
							</a-col>
							<a-col :md="10" :sm="10" v-else>
								<a-input v-model="compares[i].value" clearable placeholder="值" @change="e => valueChange(i,e)" />
							</a-col>
							<a-col :md="4" :sm="4" v-if="compares[i].fieldName=='CreatedUserId'">		
								<a-button icon="search" @click="setUser(i)" v-if="compares.length>0"/>
							</a-col>
							<a-col :md="4" :sm="4" v-if="compares[i].fieldName=='CreatedOrgId'">		
								<a-button icon="search" @click="setRole(i)" v-if="compares.length>0"/>
							</a-col>
						</a-form-item>
					</div>
				</a-form>
			</a-tab-pane>
		</a-tabs>
	</div>
</template>

<script>
	import jsplumb from 'jsplumb'

	export default {
		props: ['plumb', 'flowData', 'select','fieldNames'],
		components: {
			jsplumb
		},
		data () {
			return {
				currentSelect: this.select,
				formItemLayout: {
					labelCol: { span: 6 },
					wrapperCol: { span: 16 }
				},
				compares:this.select.compares,
				setInfo:this.select.setInfo,
				specialName:"",
				currentDepart:false,
				operations:[{id:'>',name:'>'},
				{id:'<',name:'<'},{id:'>=',name:'>='},
				{id:'<=',name:'<='},{id:'=',name:'='},
				{id:'!=',name:'!='},{id:'in',name:'in'},
				{id:'not in',name:'not in'},
				],	
				conditions:[{id:'and',name:'并且'},
				{id:'or',name:'或者'}],		
				specialShow:false,
				nodeDesignateData:[
					{id:'ALL_USER',name:'所有用户'}
					,{id:'SPECIAL_USER',name:'指定用户'},{id:'SPECIAL_ROLE',name:'指定角色'}
					,{id:'RUNTIME_SPECIAL_ROLE',name:'运行时指定角色'},{id:'RUNTIME_SPECIAL_USER',name:'运行时指定用户'}
				],
				nodeRejectType:[{id:"0",name:"前一步"},{id:"1",name:"第一步"}],
				nodeConfluenceType:[{id:"all",name:"全部通过"},{id:"one",name:"至少有一个通过"}],
				activeKey: 'flow-attr',
				currentCompare:null,
			}
		},
		methods: {
			nameChange (e) {
				this.currentSelect.name = e.target.value;
				this.currentSelect.setInfo.nodeName = this.currentSelect.name;
				this.currentSelect.setInfo.nodeCode = this.currentSelect.name;

			},
			linkLabelChange (e) {
				const that = this;
				let label = e.target.value;

				that.currentSelect.label = label;
				let conn = that.plumb.getConnections({
					source: that.currentSelect.sourceId,
					target: that.currentSelect.targetId
				})[0];
				if (label != '') {
					conn.setLabel({
						label: label,
						cssClass: 'linkLabel'
					});
				} else {
					let labelOverlay = conn.getLabelOverlay();
					if (labelOverlay) conn.removeOverlay(labelOverlay.id);
				}
			},
			linkThirdPartyUrlChange (e) {
				const that = this;
				let thirdPartyUrl = e.target.value;
				that.currentSelect.setInfo.thirdPartyUrl = thirdPartyUrl;
			},
			nodeRejectTypeChange (e) {
				const that = this;
				let nodeRejectType = e;
				that.setInfo.nodeRejectType = nodeRejectType;
				that.currentSelect.setInfo.nodeRejectType = nodeRejectType;
			},
			nodeConfluenceTypeChange (e) {
				const that = this;
				let nodeConfluenceType = e;
				that.setInfo.nodeConfluenceType = nodeConfluenceType;
				that.currentSelect.setInfo.nodeConfluenceType = nodeConfluenceType;
			},
			addList () {
				const that = this;
				let compares = that.compares;
				compares.push({fieldType:'form',value:'',name:'',condition:'and',valueName:'',operation:'='});
				that.compares = compares;
				that.currentSelect.compares = compares;
			},
			subList (e) {
				const that = this;
				let compares = that.compares;
				if(compares.length==1)
				{
					compares=[{fieldType:'form',value:'',name:'',condition:'and',valueName:'',operation:'='}];
				}
				else
				{
					compares.splice(e, 1);
				}
				that.compares = compares;
				that.currentSelect.compares = compares;
			},
			fieldNameChange (i,e) {
				const that = this;
				const compares = that.compares;
				compares[i].fieldName = e;
				that.currentSelect.compares = compares;
			},
			conditionChange (i,e) {
				const that = this;
				const compares = that.compares;
				compares[i].condition = e;
				that.currentSelect.compares = compares;
			},
			operationChange (i,e) {
				const that = this;
				const compares = that.compares;
				compares[i].operation = e;
				that.currentSelect.compares = compares;
			},
			valueChange (i,e) {
				const that = this;
				const compares = that.compares;
				that.currentSelect.compares = compares;
			},
      		//打开选择用户界面
			setUser (value) {
				const that = this;
				if(that.currentSelect.type=="link")
				{
					that.currentCompare=value;
					this.$emit('openUser',null);
				}
				else{
					that.currentCompare=null;
					this.$emit('openUser',that.setInfo.nodeDesignateData);
				}

			},
      		//打开选择角色界面
			setRole (value) {
				const that = this;
				if(that.currentSelect.type=="link")
				{
					that.currentCompare=value;
					this.$emit('openUser',null);
				}
				else{
					that.currentCompare=null;
					this.$emit('openRole',that.setInfo.nodeDesignateData);
				}
			},
			setFlowAttrForm(record)
			{
				const that = this;
				if(!!record)
				{
					const nodeDesignateData=[];
					const nodeDesignateName=[];
					record.forEach(item => {
						nodeDesignateData.push(item.id);
						nodeDesignateName.push(item.name);
					});
					if(that.currentSelect.type=="link")
					{
						that.compares[that.currentCompare].value = nodeDesignateData.join(',')
						that.compares[that.currentCompare].valueName = nodeDesignateName.join(',')
						that.currentSelect.compares = that.compares;
					}
					else{
						that.setInfo.nodeDesignateData = nodeDesignateData;
						that.setInfo.nodeDesignateName = nodeDesignateName;
						that.currentSelect.setInfo.nodeDesignateName = nodeDesignateName;
						that.currentSelect.setInfo.nodeDesignateData = nodeDesignateData;
						if(nodeDesignateName.length>0)
						{
							that.specialName = nodeDesignateName.join(',');
						}
					}
				}			
			},
			currentDepartChange(e)
			{
				const that = this;
				let currentDepart = e;
				that.currentDepart = currentDepart;
				that.setInfo.currentDepart = currentDepart;
				that.currentSelect.setInfo = that.setInfo;
			},
			nodeDesignateChange(e){
				const that = this;
				let nodeDesignate = e;
				that.setInfo.nodeDesignate = nodeDesignate;
				that.setInfo.nodeDesignateData = [];
				that.setInfo.nodeDesignateName = [];
				that.setInfo.currentDepart = false;
				that.currentDepart = false;
				that.specialName = '';
				if(nodeDesignate == 'SPECIAL_USER')
				{
					that.specialShow = true;
				}
				else if(nodeDesignate == 'SPECIAL_ROLE')
				{
					that.specialShow = true;
				}
				else
				{
					that.specialShow = false;
				}	
				that.currentSelect.setInfo.nodeDesignate = nodeDesignate;
			}
		},
		watch: {
			select (val) {
				this.currentSelect = val;
				if (this.currentSelect.type == 'link') {
					this.activeKey = 'link-attr';
					if(!this.currentSelect.compares || this.currentSelect.compares.length == 0)
					{
						this.currentSelect.compares=[{fieldType:'form',value:'',name:'',condition:'and',valueName:'',operation:'='}]
					}
					this.compares = this.currentSelect.compares
				} else if (!this.currentSelect.type) {
					this.activeKey = 'flow-attr';
				} else {
					this.activeKey = 'node-attr';
					if(this.currentSelect.type=='node' || this.currentSelect.type == 'join')
					{
						if(!this.currentSelect.setInfo)
						{
							this.currentSelect.setInfo={};
							this.currentSelect.setInfo.nodeCode = this.currentSelect.name;
							this.currentSelect.setInfo.nodeName = this.currentSelect.name;
						}
						if(!this.currentSelect.setInfo.nodeDesignate)
						{
							this.currentSelect.setInfo.nodeDesignate='ALL_USER'
						}
						if(!this.currentSelect.setInfo.nodeRejectType)
						{
							this.currentSelect.setInfo.nodeRejectType='1'
						}
						if(!this.currentSelect.setInfo.nodeConfluenceType)
						{
							this.currentSelect.setInfo.nodeConfluenceType='all'
						}
						if(this.currentSelect.setInfo.nodeDesignate=='SPECIAL_USER' || this.currentSelect.setInfo.nodeDesignate=='SPECIAL_ROLE')
						{
							this.specialShow = true;
              this.specialName = this.currentSelect.setInfo.nodeDesignateName;
              this.currentDepart=this.currentSelect.setInfo.currentDepart;
						}	
						this.setInfo = this.currentSelect.setInfo;
					}
				}
			},
			currentSelect: {
				handler (val) {
					this.$emit('update:select', val);
				},
				deep: true
			}
		}
	}
</script>

<style lang="less" scoped>
	@import '../style/flow-attr.less';
</style>
