<template>
	<div style="height: 60vh">
		<a-layout class="container">
			<a-layout-sider
        		v-show="needShow"
				width="200"
				theme="light"
				class="select-area">
				<a-row style="padding:5px">
					<a-checkable-tag v-model="tag.checked0" @change="toggleNodeShow0" class="tag">工具</a-checkable-tag>
					<div align="center">
						<a-list
							:grid="{ gutter: 8, column: 1 }"
							v-if="tag.toolShow">
							<a-list-item>
								<a-button-group>
									<a-button
										v-for="(tool, index) in field.tools"
										:key="index"
										:icon="tool.icon"
										:type="currentTool.type == tool.type ? 'primary': 'default'"
										@click="selectTool(tool.type)">
									</a-button>
								</a-button-group>
							</a-list-item>
						</a-list>
					</div>
				</a-row>
				<a-row style="padding:5px">
					<a-checkable-tag v-model="tag.checked1" @change="toggleNodeShow1" class="tag">基础节点</a-checkable-tag>
					<div align="center">
						<a-list
							:grid="{ gutter: 8, column: 2 }"
							v-if="tag.commonNodeShow">
							<a-list-item v-for="(commonNode, index) in field.commonNodes" :key="index">
								<div class="node-item" :type="commonNode.type" belongto="commonNodes">
									<a-icon :type="commonNode.icon" /> {{ commonNode.name }}
								</div>
							</a-list-item>
						</a-list>
					</div>
				</a-row>
				<a-row style="padding:5px">
					<a-checkable-tag v-model="tag.checked3" @change="toggleNodeShow3" class="tag">泳道节点</a-checkable-tag>
					<div align="center">
						<a-list
							:grid="{ gutter: 8, column: 2 }"
							v-if="tag.laneNodeShow">
							<a-list-item v-for="(laneNode, index) in field.laneNodes" :key="index">
								<div class="node-item" :type="laneNode.type" belongto="laneNodes">
									<a-icon :type="laneNode.icon" /> {{ laneNode.name }}
								</div>
							</a-list-item>
						</a-list>
					</div>
				</a-row>
			</a-layout-sider>
			<a-layout>
				<a-layout-header v-show="needShow" class="header-option" style="background-color:#fff;padding-right: 10px;">
					<a-popconfirm title="确认要重新绘制吗？" placement="bottom" okText="确认" cancelText="取消" @confirm="clear">
						<a-tooltip title="重新绘制" placement="bottom">
							<a-button class="header-option-button" size="small" icon="sync"></a-button>
						</a-tooltip>
					</a-popconfirm>
					<a-tooltip :title="flowData.config.showGridText" placement="bottom">
						<a-button
							@click="toggleShowGrid"
							class="header-option-button"
							size="small"
							:icon="flowData.config.showGridIcon">
						</a-button>
					</a-tooltip>
          				<a-tooltip title="设置" placement="bottom">
						<a-button @click="setting" class="header-option-button" size="small" icon="setting"></a-button>
					</a-tooltip>
          				<a-tooltip title="JSON" placement="bottom">
						<a-button @click="openTest" class="header-option-button" size="small" icon="save"></a-button>
					</a-tooltip>
					<a-popconfirm 
						title="请选择帮助项：" 
						placement="bottom" 
						okType="default" 
						okText="快捷键大全" 
						cancelText="使用文档" 
						@confirm="shortcutHelper"
						@cancel="usingDoc">
						<a-icon slot="icon" type="question-circle-o" style="color: red" />
						<a-tooltip title="帮助" placement="bottom">
							<a-button class="header-option-button" size="small" icon="book"></a-button>
						</a-tooltip>
					</a-popconfirm>
				</a-layout-header>
				<a-layout-content class="flowContent">
					<flow-area
						ref="flowArea"
						:browserType="browserType"
						:flowData="flowData"
						:select.sync="currentSelect"
						:selectGroup.sync="currentSelectGroup"
						:plumb="plumb"
						:currentTool="currentTool"
            			:activityId="activityId"
						@findNodeConfig="findNodeConfig"
						@selectTool="selectTool"
						@getShortcut="getShortcut"
						@saveFlow="saveFlow">
					</flow-area>
					<vue-context-menu
						:contextMenuData="linkContextMenuData"
						@deleteLink="deleteLink">
					</vue-context-menu>
				</a-layout-content>
			</a-layout>
			<a-layout-sider
				width="300"
				theme="light"
				class="attr-area"
				@mousedown.stop="loseShortcut">
				<flow-attr ref="flowAttrForm" :plumb="plumb" :flowData="flowData" :needShow="needShow" :fieldNames.sync="fieldNames" :select.sync="currentSelect" @openUser="openUser()" @openRole="openRole()"></flow-attr>
			</a-layout-sider>
		</a-layout>
		<setting-modal ref="settingModal"></setting-modal>
		<shortcut-modal ref="shortcutModal"></shortcut-modal>
		<test-modal ref="testModal" @loadFlow="loadFlow" @clear123="clear()"></test-modal>
	</div>
</template>

<script>
	import jsplumb from 'jsplumb'
	import { tools, commonNodes, laneNodes } from './config/basic-node-config.js'
	import { flowConfig } from './config/args-config.js'
	import $ from 'jquery'
	import 'jquery-ui/ui/widgets/draggable'
	import 'jquery-ui/ui/widgets/droppable'
	import 'jquery-ui/ui/widgets/resizable'
	import { ZFSN } from './util/ZFSN.js'
	import FlowArea from './modules/FlowArea'
	import FlowAttr from './modules/FlowAttr'
	import SettingModal from './modules/SettingModal'
	import ShortcutModal from './modules/ShortcutModal'
	import UsingDocModal from './modules/UsingDocModal'
	import TestModal from './modules/TestModal'

	export default {
		name: 'vfd',
		components: {
			jsplumb,
			flowConfig,
			FlowArea,
			FlowAttr,
			SettingModal,
			ShortcutModal,
			UsingDocModal,
			TestModal
		},
    	//条件选择字段
		props: ['fieldNames','needShow','activityId'],
		mounted () {
			const that = this;
			that.dealCompatibility();
			that.initNodeSelectArea();
			that.initJsPlumb();
			that.listenShortcut();
			that.initFlow();
			that.listenPage();
		},
		data () {
			return {
				tag: {
					checked0: true,
					checked1: true,
					checked2: true,
					checked3: true,
					toolShow: true,
					commonNodeShow: true,
					highNodeShow: true,
					laneNodeShow: true
				},
				browserType: 3,
				plumb: {},
				field: {
					tools: tools,
					commonNodes: commonNodes,
					laneNodes: laneNodes
				},
				flowData: {
					nodeList: [],
					linkList: [],
					attr: {
						id: ''
					},
					config: {
						showGrid: true,
						showGridText: '隐藏网格',
						showGridIcon: 'eye'
					},
					status: flowConfig.flowStatus.CREATE,
					remarks: []
				},
				currentTool: {
					type: 'drag',
					icon: 'drag',
					name: '拖拽'
				},
				currentSelect: {},
				currentSelectGroup: [],
				activeShortcut: true,
				linkContextMenuData: flowConfig.contextMenu.link,
				flowPicture: {
					url: '',
					modalVisible: false,
					closable: false,
					maskClosable: false
				},
				flowLineAdditions:flowConfig.flowLineAdditions
			}
		},
		methods: {
      		//用户选择界面
			openUser(value)
			{
				this.$emit('openUser',value);
			},
      		//角色选择界面
			openRole(value)
			{
				this.$emit('openRole',value);
			},
      		//角色用户设置必须包含id、name属性的数组
			setFlowAttrForm(value)
			{
				this.$refs.flowAttrForm.setFlowAttrForm(value);
			},
			toggleNodeShow0 (flag) {
				if (!flag) {
					this.tag.toolShow = false;
				} else {
					this.tag.toolShow = true;
				}
			},
			toggleNodeShow1 (flag) {
				if (!flag) {
					this.tag.commonNodeShow = false;
				} else {
					this.tag.commonNodeShow = true;
				}
			},
			toggleNodeShow2 (flag) {
				if (!flag) {
					this.tag.highNodeShow = false;
				} else {
					this.tag.highNodeShow = true;
				}
			},
			toggleNodeShow3 (flag) {
				if (!flag) {
					this.tag.laneNodeShow = false;
				} else {
					this.tag.laneNodeShow = true;
				}
			},
			getBrowserType () {
				let userAgent = navigator.userAgent;
				let isOpera = userAgent.indexOf("Opera") > -1;
				if (isOpera) {
					return 1;
				};
				if (userAgent.indexOf("Firefox") > -1) {
					return 2;
				}
				if (userAgent.indexOf("Chrome") > -1) {
					return 3;
				}
				if (userAgent.indexOf("Safari") > -1) {
					return 4;
				}
				if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
					alert('IE浏览器支持性较差，推荐使用Firefox或Chrome');
					return 5;
				}
				if (userAgent.indexOf("Trident") > -1) {
					alert('Edge浏览器支持性较差，推荐使用Firefox或Chrome');
					return 6;
				};
			},
			dealCompatibility () {
				const that = this;

				that.browserType = that.getBrowserType();
				if (that.browserType == 2) {
					flowConfig.shortcut.scaleContainer = {
						code: 16,
						codeName: 'SHIFT(chrome下为ALT)',
						shortcutName: '画布缩放',
					};
				}
			},
			initJsPlumb () {
				const that = this;

				that.plumb = jsPlumb.getInstance(flowConfig.jsPlumbInsConfig);

				that.plumb.bind('beforeDrop', function(info) {
					let sourceId = info.sourceId;
					let targetId = info.targetId;

					if (sourceId == targetId) return false;
					let filter = that.flowData.linkList.filter(link => (link.sourceId == sourceId && link.targetId == targetId));
					if (filter.length > 0) {
						that.$message.error('同方向的两节点连线只能有一条！');
						return false;
					}
					return true;
				});

				that.plumb.bind('connection', function(conn, e) {
					let connObj = conn.connection.canvas;
					let o = {}, id, label;
					if (that.flowData.status == flowConfig.flowStatus.CREATE || that.flowData.status == flowConfig.flowStatus.MODIFY) {
						id = 'link-' + ZFSN.getId();
						label = '';
					} else if (that.flowData.status == flowConfig.flowStatus.LOADING) {
						let l = that.flowData.linkList[that.flowData.linkList.length - 1];
						id = l.id;
						label = l.label;
					}
					connObj.id = id;
					o.type = 'link';
					o.id = id;
					o.sourceId = conn.sourceId;
					o.targetId = conn.targetId;
					o.label = label;
					o.cls = {
						linkType: flowConfig.jsPlumbInsConfig.Connector[0],
						linkColor: flowConfig.jsPlumbInsConfig.PaintStyle.stroke,
						linkThickness: flowConfig.jsPlumbInsConfig.PaintStyle.strokeWidth
					};
					$('#' + id).bind('contextmenu', function(e) {
						that.showLinkContextMenu(e);
						that.currentSelect = that.flowData.linkList.filter(l => l.id == id)[0];
					});
					$('#' + id).bind('click', function(e) {
						let event = window.event || e;
						event.stopPropagation();
						that.currentSelect = that.flowData.linkList.filter(l => l.id == id)[0];
					});
					if (that.flowData.status != flowConfig.flowStatus.LOADING) that.flowData.linkList.push(o);
				});

				that.plumb.importDefaults({
					ConnectionsDetachable: flowConfig.jsPlumbConfig.conn.isDetachable
				});

				ZFSN.consoleLog(['实例化JsPlumb成功...']);
			},
			initNodeSelectArea () {
				$(document).ready(function() {
					$(".node-item").draggable({
						opacity: flowConfig.defaultStyle.dragOpacity,
						helper: 'clone',
						cursorAt: {
							top: 16,
							left: 60
						},
						containment: "window",
						revert: "invalid"
					});
					ZFSN.consoleLog(['初始化节点选择列表成功...']);
				});
			},
			listenShortcut () {
				const that = this;
				document.onkeydown = function(e) {
					let event = window.event || e;

					if (!that.activeShortcut) return;
					let key = event.keyCode;

					switch (key) {
						case flowConfig.shortcut.multiple.code:
							that.$refs.flowArea.rectangleMultiple.flag = true;
							break;
						case flowConfig.shortcut.dragContainer.code:
							that.$refs.flowArea.container.dragFlag = true;
							break;
						case flowConfig.shortcut.scaleContainer.code:
							that.$refs.flowArea.container.scaleFlag = true;
							break;
						case flowConfig.shortcut.dragTool.code:
							that.selectTool('drag');
							break;
						case flowConfig.shortcut.connTool.code:
							that.selectTool('connection');
							break;
						case flowConfig.shortcut.zoomInTool.code:
							that.selectTool('zoom-in');
							break;
						case flowConfig.shortcut.zoomOutTool.code:
							that.selectTool('zoom-out');
							break;
						case 37:
							that.moveNode('left');
							break;
						case 38:
							that.moveNode('up');
							break;
						case 39:
							that.moveNode('right');
							break;
						case 40:
							that.moveNode('down');
							break;
					}
				}
				document.onkeyup = function(e) {
					let event = window.event || e;

					let key = event.keyCode;
					if (key == flowConfig.shortcut.dragContainer.code) {
						that.$refs.flowArea.container.dragFlag = false;
					} else if (key == flowConfig.shortcut.scaleContainer.code) {
						event.preventDefault();
						that.$refs.flowArea.container.scaleFlag = false;
					} else if (key == flowConfig.shortcut.multiple.code) {
						that.$refs.flowArea.rectangleMultiple.flag = false;
					}
				}

				ZFSN.consoleLog(['初始化快捷键成功...']);
			},
			listenPage () {
				window.onbeforeunload = function (e) {
					e = e || window.event;
					if (e) {
						e.returnValue = '关闭提示';
					}
					return '关闭提示';
				};
			},
			initFlow () {
				const that = this;
				if (that.flowData.status == flowConfig.flowStatus.CREATE) {
					that.flowData.attr.id = 'flow-' + ZFSN.getId();
				} else {
					that.loadFlow();
				}
				ZFSN.consoleLog(['初始化流程图成功...']);
			},
			loadFlow (json) {
				const that = this;
				setTimeout(() => {
					that.flowLineAdditions.forEach(item=>{
						that.fieldNames.push(item);
					})	
					const map = new Map()
					const list = that.fieldNames.filter(key => !map.has(key.id) && map.set(key.id, 1)) 
					that.$emit('update:fieldNames', list)
				}, 100)
				that.clear();
				let loadData =JSON.parse(json);
				that.flowData.attr = loadData.attr;
				that.flowData.config = loadData.config;
				that.flowData.status = flowConfig.flowStatus.LOADING;
				that.plumb.batch(function() {
					let nodeList = loadData.nodeList;
					let areaList = loadData.areaList;
					nodeList.forEach(function(node, index) {
						that.flowData.nodeList.push(node);
					});
					if(!!areaList && areaList.length > 0)
					{
						areaList.forEach(function(node, index) {
							that.flowData.nodeList.push(node);
						});
					}
					let linkList = loadData.linkList;
					that.$nextTick(() => {
						linkList.forEach(function(link, index) {
							that.flowData.linkList.push(link);
							let conn = that.plumb.connect({
								source: link.sourceId,
								target: link.targetId,
								anchor: flowConfig.jsPlumbConfig.anchor.default,
								connector: [
									link.cls.linkType,
									{
										gap: 5,
										cornerRadius: 8,
										alwaysRespectStubs: true
									}
								],
								paintStyle: {
									stroke: link.cls.linkColor,
									strokeWidth: link.cls.linkThickness
								}
							});
							if (link.label != '') {
								conn.setLabel({
									label: link.label,
									cssClass: 'linkLabel'
								});
							}
						});
						that.currentSelect = {};
						that.currentSelectGroup = [];
						that.flowData.status = flowConfig.flowStatus.MODIFY;
					});
				}, true);
			},
			findNodeConfig (belongto, type, callback) {
				let node = null;
				switch (belongto) {
					case 'commonNodes':
						node = commonNodes.filter(n => n.type == type);
						break;
					case 'laneNodes':
						node = laneNodes.filter(n => n.type == type);
						break;
				}
				if (node && node.length >= 0) node = node[0];
				callback(node);
			},
			selectTool (type) {
				let tool = tools.filter(t => t.type == type);
				if (tool && tool.length >= 0) this.currentTool = tool[0];

				switch (type) {
					case 'drag':
						this.changeToDrag();
						break;
					case 'connection':
						this.changeToConnection();
						break;
					case 'zoom-in':
						this.changeToZoomIn();
						break;
					case 'zoom-out':
						this.changeToZoomOut();
						break;
				}
			},
			changeToDrag () {
				const that = this;

				that.flowData.nodeList.forEach(function(node, index) {
					let f = that.plumb.toggleDraggable(node.id);
					if (!f) {
						that.plumb.toggleDraggable(node.id);
					}
					if (node.type != 'x-lane' && node.type != 'y-lane') {
						that.plumb.unmakeSource(node.id);
						that.plumb.unmakeTarget(node.id);
					}
				});
			},
			changeToConnection() {
				const that = this;

				that.flowData.nodeList.forEach(function(node, index) {
					let f = that.plumb.toggleDraggable(node.id);
					if (f) {
						that.plumb.toggleDraggable(node.id);
					}
					if (node.type != 'x-lane' && node.type != 'y-lane') {
						that.plumb.makeSource(node.id, flowConfig.jsPlumbConfig.makeSourceConfig);
						that.plumb.makeTarget(node.id, flowConfig.jsPlumbConfig.makeTargetConfig);
					}
				});

				that.currentSelect = {};
				that.currentSelectGroup = [];
			},
			changeToZoomIn () {
				console.log('切换到放大工具');
			},
			changeToZoomOut () {
				console.log('切换到缩小工具');
			},
			checkFlow () {
				const that = this;
				let nodeList = that.flowData.nodeList;
				let linkList = that.flowData.linkList;
				let areaList = [];
				for (let index = nodeList.length-1; index >=0; index--) {
					const item = nodeList[index];
					if(item.type == 'x-lane' || item.type == 'y-lane')
					{
						nodeList.splice(index,1);
						areaList.push(item);
					}
					if(!!item.setInfo)
					{
						if((item.setInfo.nodeDesignate=="SPECIAL_USER" || item.setInfo.nodeDesignate=="SPECIAL_ROLE")&& item.setInfo.nodeDesignateData.length == 0)
						{
							this.$message.error('节点:'+item.setInfo.nodeName+',执行权限需要配置！');
							return false;
						}
					}
				}
				that.flowData.areaList = areaList;
				linkList.forEach(item=>{
					if(!!item.compares)
					{
						for (let index = item.compares.length-1; index >=0; index--) {
							const compare = item.compares[index];
							//这些字段没有就去掉条件
							if(!compare.operation || !compare.fieldName ||!compare.value )
							{
								item.compares.splice(index,1);
							}
						}
					}
				});
				if (nodeList.length <= 0) {
					this.$message.error('流程图中无任何节点！');
					return false;
				}
				return true;
			},
			saveFlow () {
				const that = this;
				if (!that.checkFlow()) return;
				let flowObj = Object.assign({}, that.flowData);
				flowObj.status = flowConfig.flowStatus.SAVE;
				let d = JSON.stringify(flowObj);
				console.log(d);
				//this.$message.success('保存流程成功！请查看控制台。');
				return d;
			},
			cancelDownLoadFlowPicture () {
				this.flowPicture.url = '';
				this.flowPicture.modalVisible = false;
			},
			clear () {
				const that = this;
				that.flowData.nodeList.forEach(function(node, index) {
					that.plumb.remove(node.id);
				});
				that.currentSelect = {};
				that.currentSelectGroup = [];
				that.flowData.nodeList = [];
				that.flowData.linkList = [];
				that.flowData.remarks = [];
			},
			toggleShowGrid () {
				let flag = this.flowData.config.showGrid;
				if (flag) {
					this.flowData.config.showGrid = false;
					this.flowData.config.showGridText = '显示网格';
					this.flowData.config.showGridIcon = 'eye-invisible';
				} else {
					this.flowData.config.showGrid = true;
					this.flowData.config.showGridText = '隐藏网格';
					this.flowData.config.showGridIcon = 'eye';
				}
			},
			setting () {
				this.$refs.settingModal.open();
			},
			shortcutHelper () {
				this.$refs.shortcutModal.open();
			},
			usingDoc () {
				window.open("https://gitee.com/yjblogs/VFD?_from=gitee_search");
			},
			exit () {
				alert('退出流程设计器...');
			},
			showLinkContextMenu (e) {
				let event = window.event || e;

				event.preventDefault();
				event.stopPropagation();
				$('.vue-contextmenuName-flow-menu').css('display', 'none');
				$('.vue-contextmenuName-node-menu').css('display', 'none');
				let x = event.clientX;
				let y = event.clientY;
				this.linkContextMenuData.axis = { x, y };
			},
			deleteLink () {
				const that = this;
				let sourceId = that.currentSelect.sourceId;
				let targetId = that.currentSelect.targetId;
				that.plumb.deleteConnection(that.plumb.getConnections({
					source: sourceId,
					target: targetId
				})[0]);
				let linkList = that.flowData.linkList;
				linkList.splice(linkList.findIndex(link => (link.sourceId == sourceId || link.targetId == targetId)), 1);
				that.currentSelect = {};
			},
			loseShortcut () {
				this.activeShortcut = false;
			},
			getShortcut () {
				this.activeShortcut = true;
			},
			openTest () {
				const that = this;

				let flowObj = Object.assign({}, that.flowData);
				that.$refs.testModal.flowData = flowObj;
				that.$refs.testModal.testVisible = true;
			},
			moveNode (type) {
				const that = this;

				let m = flowConfig.defaultStyle.movePx, isX = true;
				switch (type) {
					case 'left':
						m = -m;
						break;
					case 'up':
						m = -m;
						isX = false;
						break;
					case 'right':
						break;
					case 'down':
						isX = false;
				}

				if (that.currentSelectGroup.length > 0) {
					that.currentSelectGroup.forEach(function(node, index) {
						if (isX) {
							node.x += m;
						} else {
							node.y += m;
						}
					});
					that.plumb.repaintEverything();
				} else if (that.currentSelect.id) {
					if (isX) {
						that.currentSelect.x += m;
					} else {
						that.currentSelect.y += m;
					}
					that.plumb.repaintEverything();
				}
			}
		}
	}
</script>

<style lang="less" scoped>
	@import './style/flow-designer.less';
</style>
