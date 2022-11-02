<template>
  <a-row :gutter="24">
    <a-col :md="4" :sm="24" style="padding: 0 0 0 0;">
      <a-card :bordered="false" :loading="treeLoading" class="leftTree">
        <div v-if="this.docTree!='' ">
          <a-tree style="scroll:true" :treeData="docTree" v-if="docTree.length" @select="handleClick"
                  :defaultExpandAll="false" :defaultExpandedKeys="defaultExpandedKeys" :replaceFields="replaceFields"/>
        </div>
        <div v-else>
          <a-empty :image="simpleImage"/>
        </div>
      </a-card>
    </a-col>
    <a-col :md="20" :sm="24">
      <a-card :bordered="false" :bodyStyle="tstyle">
        <div class="table-page-search-wrapper" v-if="hasPerm('Document:page')">
          <a-form layout="inline">
            <a-row :gutter="48">
              <a-col :md="6" :sm="24">
                <a-form-item label="名称">
                  <a-input v-model="queryParam.name" allow-clear placeholder="请输入名称"/>
                </a-form-item>
              </a-col>
              <a-col :md="6" :sm="24">
                <a-form-item label="类型">
                  <a-select style="width: 100%" v-model="queryParam.fileType" placeholder="请选择类型">
                    <a-select-option v-for="(item,index) in fileTypeData" :key="index" :value="item.name">{{
                      item.name
                      }}
                    </a-select-option>
                  </a-select>
                </a-form-item>
              </a-col>
              <a-col :md="6" :sm="24">
                <a-form-item label="标签">
                  <a-select style="width: 100%" v-model="queryParam.label" placeholder="请选择标签">
                    <a-select-option v-for="(item, index) in documentlabelData" :key="index" :value="item.code">{{
                      item.name
                      }}
                    </a-select-option>
                  </a-select>
                </a-form-item>
              </a-col>

              <a-col :md="6" :sm="24">
                <span class="table-page-search-submitButtons">
                  <a-button type="primary" @click="$refs.table.refresh(true)">查询</a-button>
                  <a-button style="margin-left: 8px" @click="() => queryParam = {}">重置</a-button>
                </span>
              </a-col>
            </a-row>
          </a-form>
        </div>
      </a-card>
      <a-card :bordered="false">
        <s-table
          ref="table"
          :columns="columns"
          :data="loadData"
          :alert="true"
          :rowKey="(record) => record.id"
          :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }">
          <template class="table-operator" slot="operator" v-if="hasPerm('Document:add')">
            <div class="file-tool">
              <div class="btn-tool">
                <a-button type="primary" v-if="hasPerm('Document:add')" icon="folder-add"
                          @click="$refs.addForm.add(pId)">
                  新建文件夹
                </a-button>
                <a-dropdown>
                  <a-menu slot="overlay">
                    <a-menu-item key="1" @click="$refs.uploadFiles.upload(pId)">
                      上传文件
                    </a-menu-item>
                    <a-menu-item key="2" @click="$refs.uploadFolder.upload(pId)">
                      上传文件夹
                    </a-menu-item>
                  </a-menu>
                  <a-button v-if="hasPerm('Document:add')" icon="upload">上传
                    <a-icon type="down"/>
                  </a-button>
                </a-dropdown>
                <a-button type="danger" v-if="hasPerm('Document:delete')" :disabled="!hasSelected" icon="delete"
                          @click="massDelete"
                          :loading="loading">删除
                </a-button>
                <a-button v-if="hasPerm('Document:edit')" :disabled="!hasSelected" icon="edit" @click="massEdit"
                          :loading="loading">移动
                </a-button>
                <a-button type="dashed" :disabled="!hasSelected" @click="clearSelected"
                          :loading="loading">清空选择
                </a-button>
              </div>
              <div class="path-tool">
                <template v-if="pathStack.length">
                  <a @click="goBack">返回上一级</a>
                  <a-divider type="vertical"/>
                </template>
                <a @click="goHome" style="margin-right: 6px">全部文件</a>
                <template v-for="item in pathStack">
                  <a-icon type="right" :key="item.id + 'icon'"/>
                  <a @click="go(item.id)" :key="item.id" style="margin: 0 6px;">{{item.name}}</a>
                </template>
              </div>
            </div>
          </template>
          <template slot="nameSlots" slot-scope="text,record">
            <template v-if="record.fileType === '文件夹'">
              <a-icon type="folder-open" theme="twoTone" two-tone-color="#F7C709"/>
              <a @click="NextFolder(record)" style="margin-left: 5px;">{{ text }}</a>
            </template>

            <template v-else>
              <a-icon v-if="record.fileType === '文档'" type="file-text"/>
              <a-icon v-else-if="record.fileType === '图片'" type="file-image"/>
              <a-icon v-else-if="record.fileType === '压缩包'" type="file-zip"/>
              <a-icon v-else-if="record.fileType === '应用程序'" type="file"/>
              <a-icon v-else type="file"/>
              <a-tooltip placement="top">
                <template slot="title">
                  <span>{{ text }}</span>
                </template>
                <span style="margin-left: 5px;">{{ text }}</span>
              </a-tooltip>
            </template>
          </template>
          <span slot="fileTypeSlots" slot-scope="text">
            <a-tag v-if="text === '文件夹'" color="#ffcc00" style="margin: 0;font-size: 14px">{{text}}</a-tag>
            <a-tag v-else-if="text === '文档'" color="#3399ff" style="margin: 0;font-size: 14px">{{text}}</a-tag>
            <a-tag v-else-if="text === '图片'" color="#ff3333" style="margin: 0;font-size: 14px">{{text}}</a-tag>
            <a-tag v-else-if="text === '应用程序'" color="#A2A2A2" style="margin: 0;font-size: 14px">{{text}}</a-tag>
            <a-tag v-else-if="text === '压缩包'" color="#76CD76" style="margin: 0;font-size: 14px">{{text}}</a-tag>
            <a-tag v-else color="grey" style="margin: 0;font-size: 14px">{{text}}</a-tag>
          </span>
          <span slot="tagsSlots" slot-scope="text">
            <!--        <a-tag v-for="tag in tags" :key="tag" :color="tag === '1' ? 'volcano' : tag=== '2' ? 'geekblue' : 'green'">
            {{documentlabelData[tag - 1].name}}
          </a-tag> -->
            <a-tag v-if="text > 0" color="geekblue" style="margin: 0;font-size: 14px">
              {{ getDocLabel(text) }}
            </a-tag>
          </span>
          <!--  <span slot="fileSizeSlots" slot-scope="text">
            <a-tag v-for="tag in tags" :key="tag" :color="tag === '1' ? 'volcano' : tag=== '2' ? 'geekblue' : 'green'">
              {{documentlabelData[tag - 1].name}}
            </a-tag>
          </span> -->
          <span slot="action" slot-scope="text, record">
            <a v-if="hasPerm('Document:edit')" @click="$refs.editForm.edit(record)">重命名</a>
           <!-- <a-divider type="vertical" v-if="hasPerm('Document:edit') & hasPerm('Document:download') & record.documentType ===2 "/>
            <a v-if="hasPerm('Document:download') & record.documentType ===2 " @click="sysFileInfoDownload(record)" >下载</a> -->
             <!-- <a-divider type="vertical" v-if="hasPerm('Document:edit') & hasPerm('Document:delete')"/> -->
   <!--         <a-popconfirm v-if="hasPerm('Document:delete')" placement="topRight" title="确认删除？"
                          @confirm="() => DocumentDelete(record)">
              <a>删除</a> -->
             <a-divider type="vertical"/>
             <a-dropdown>
                <a class="ant-dropdown-link">
                  更多 <a-icon type="down" />
                </a>
                <a-menu slot="overlay">
                  <a-menu-item v-if="hasPerm('Document:download') & (record.fileType ==='文档'||record.fileType ==='图片')">
                    <a @click="preview(record)">预览</a>
                  </a-menu-item>
                  <a-menu-item v-if="hasPerm('Document:download')  &(record.fileSuffix === 'doc' || record.fileSuffix === 'docx') ">
                    <a @click="$refs.editForm.edit(record)">编辑</a>
                  </a-menu-item>
                  <a-menu-item v-if="hasPerm('Document:download')">
                    <a @click="DocumentDownload(record)">下载</a>
                  </a-menu-item>
                  <a-menu-item v-if="hasPerm('Document:delete')">
                    <a-popconfirm placement="topRight" title="确认删除？" @confirm="() => DocumentDelete(record)">
                      <a>删除</a>
                    </a-popconfirm>
                  </a-menu-item>
                </a-menu>
              </a-dropdown>
            </a-popconfirm>
          </span>
        </s-table>
        <add-form ref="addForm" @ok="handleOk"/>
        <edit-form ref="editForm" @ok="handleOk"/>
        <upload-files ref="uploadFiles" @ok="handleOk"/>
        <upload-folder ref="uploadFolder" @ok="handleOk"/>
        <mass-edit-form ref="massEditForm" @ok="handleOk"/>
          <preview-form ref="previewForm"/>
      </a-card>
    </a-col>
  </a-row>
</template>
<script>
  import {
    STable
  } from '@/components'
  import {
    Empty
  } from 'ant-design-vue'
  import {
    DocumentPage,
    DocumentTree,
    DocumentDelete,
    DocumentDeletes,
    DocumentDownload,
    DocumentPreview
  } from '@/api/modular/system/fileManage/documentManage'
  import addForm from './addForm.vue'
  import editForm from './editForm.vue'
  import uploadFiles from './upload/uploadFiles.vue'
  import uploadFolder from './upload/uploadFolder.vue'
  import previewForm from './previewForm'
  
  import {
    findParents
  } from '../../../../utils/treeUtils'
  import MassEditForm from './massEditForm'

  export default {
    components: {
      MassEditForm,
      STable,
      addForm,
      editForm,
      previewForm,
      uploadFiles,
      uploadFolder
    },
    data() {
      return {
        queryParam: {},
        columns: [{
          title: '名称',
          align: 'left',
          width: '240px',
          ellipsis: true,
          dataIndex: 'name',
          scopedSlots: {
            customRender: 'nameSlots'
          }
        },
          {
            title: '类型',
            align: 'left',
            dataIndex: 'fileType',
            scopedSlots: {
              customRender: 'fileTypeSlots'
            }
          },
          {
            title: '创建时间',
            align: 'left',
            ellipsis: true,
            dataIndex: 'createdTime'
          },
          {
            title: '创建人',
            align: 'left',
            ellipsis: true,
            dataIndex: 'createdUserName'
          },
          {
            title: '修改时间',
            align: 'left',
            ellipsis: true,
            dataIndex: 'updatedTime'
          },
          {
            title: '修改人',
            align: 'left',
            ellipsis: true,
            dataIndex: 'updatedUserName'
          },
          {
            title: '大小',
            align: 'left',
            dataIndex: 'fileSize'
          },
          {
            title: '标签',
            align: 'left',
            dataIndex: 'label',
            // ellipsis: true,
            scopedSlots: {
              customRender: 'tagsSlots'
            }
          },
          {
            title: '备注',
            align: 'left',
            ellipsis: true,
            dataIndex: 'remark'
          }
        ],
        tstyle: {
          'padding-bottom': '0px',
          'margin-bottom': '10px'
        },
        // 加载数据方法 必须为 Promise 对象
        loadData: parameter => {
          return DocumentPage(Object.assign(parameter, this.queryParam)).then((res) => {
            return res.data
          })
        },
        selectedRowKeys: [],
        selectedRows: [],
        loading: false, // 清空选择按钮loading
        fileTypeData: [],
        documentlabelData: [],
        pId: 0,
        pathStack: [], // 文件栈
        docTree: [],
        defaultExpandedKeys: [],
        autoExpandParent: true,
        treeLoading: true,
        simpleImage: Empty.PRESENTED_IMAGE_SIMPLE,
        replaceFields: {
          key: 'id',
          title: 'name',
          value: 'id'
        }
      }
    },
    computed: {
      getDocLabel() { // 传参需要让计算属性返回方法
        return function(code) {
          return this.documentlabelData.find(item => item.code === code.toString())?.name || '无'
        }
      },
      /**
       * 返回当前是否有选中行
       */
      hasSelected() {
        return this.selectedRowKeys.length > 0
      }
    },
    created() {
      if (this.hasPerm('Document:edit') || this.hasPerm('Document:delete')) {
        this.columns.push({
          title: '操作',
          width: '150px',
          dataIndex: 'action',
          scopedSlots: {
            customRender: 'action'
          }
        })
      }
      this.fileTypeData = this.$options.filters['dictData']('file_type')
      this.documentlabelData = this.$options.filters['dictData']('doc_label')
      this.DocumentTree()
    },
    methods: {
      DocumentTree() {
        DocumentTree().then(res => {
          this.treeLoading = false
          if (!res.success) {
            return
          }
          // 添加根节点
          this.docTree = [{
            id: 0,
            name: '全部文件',
            children: res.data
          }]
          this.queryParam.pId = this.docTree[0].id
          this.pId = 0
        })
      },
      /**
       * 查询参数组装
       */
      switchingDate() {
        const obj = JSON.parse(JSON.stringify(this.queryParam))
        return obj
      },
      massDelete() {
        this.$confirm({
          title: '提示',
          content: '要将上述文件放入回收站吗 ?',
          okText: '确定',
          cancelText: '取消',
          onOk: () => {
            DocumentDeletes({ ids: this.selectedRowKeys }).then(res => {
              if (res.success) {
                this.$message.success('删除成功')
                this.clearSelected()
                this.$refs.table.refresh()
              } else {
                this.$message.error('删除失败') // + res.message
              }
            })
          }
        })
      },
      massEdit() {
        this.$refs.massEditForm.edit(this.selectedRowKeys)
      },
      DocumentDelete(record) {
        DocumentDelete(record).then((res) => {
          if (res.success) {
            this.$message.success('删除成功')
            this.clearSelected()
            this.$refs.table.refresh()
          } else {
            this.$message.error('删除失败') // + res.message
          }
        })
      },
      /**
       * 返回上一级
       */
      goHome() {
        this.queryParam = {}
        // this.$set(this.queryParam, 'pId', 0)
        this.pathStack = []
        this.pId = 0
        this.refresh()
      },
      /**
       * 返回所点层级
       */
      go(id) {
        this.$set(this.queryParam, 'pId', id)
        this.pId = id
        const index = this.pathStack.findIndex(item => item.id === id)
        this.pathStack = this.pathStack.slice(0, index + 1)
        this.refresh()
      },
      /**
       * 返回上一级
       */
      goBack() {
        const path = this.pathStack.pop()
        this.$set(this.queryParam, 'pId', path.pId)
        this.pId = path.pId
        this.refresh()
      },
      NextFolder(record) {
        this.$set(this.queryParam, 'pId', record.id)
        this.pId = record.id
        this.pathStack.push({
          id: record.id,
          name: record.name,
          pId: record.pId
        }) // 文件路径入栈
        this.refresh()
      },
      /**
       * 文件树点击跳转
       * @param e 选中节点数组
       */
      handleClick(e) {
        this.queryParam = {
          pid: e.toString()
        }
        if (e[0] !== 0) { // 过滤根节点
          this.pathStack = findParents(e[0], this.docTree[0].children) // 传递文件树时不传根节点
        } else {
          this.pathStack = [] // 当为根节点时清空文件路径栈
        }
        this.refresh()
      },
      handleOk() {
        this.$refs.table.refresh()
      },
      refresh(){
        this.clearSelected()
        this.$refs.table.refresh()
      },
      /**
       * 预览文件（微软插件）
       */
      preview (record) {
        DocumentPreview({ id: record.id }).then((res) => {
          const url = process.env.VUE_APP_API_BASE_URL +'/file/'+res.data
          console.log(url)
          window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(this.getEncode64(url)));
          // window.open('https://view.officeapps.live.com/op/view.aspx?src=' + process.env.VUE_APP_API_BASE_URL + '/Document/download?id=' + record.id)
        }).catch((err) => {
          this.$message.error('预览错误：' + err.message)
        })
      },
      // base64转字符串
       getEncode64(str){
           // 对字符串进行编码
           var encode = encodeURI(str);
           // 对编码的字符串转化base64
           var base64 = btoa(encode);
           return base64;
         },
      /**
       * 下载文件（所有文件）
       */
      DocumentDownload (record) {
        this.cardLoading = true
        DocumentDownload({ id: record.id }).then((res) => {
          this.cardLoading = false
          this.downloadfile(res)
        // eslint-disable-next-line handle-callback-err
        }).catch((err) => {
          this.cardLoading = false
          this.$message.error('下载错误：获取文件流错误')
        })
      },
      downloadfile (res) {
        var blob = new Blob([res.data], { type: 'application/octet-stream;charset=UTF-8' })
        var contentDisposition = res.headers['content-disposition']
        var patt = new RegExp('filename=([^;]+\\.[^\\.;]+);*')
        var result = patt.exec(contentDisposition)
        var filename = result[1]
        var downloadElement = document.createElement('a')
        var href = window.URL.createObjectURL(blob) // 创建下载的链接
        var reg = /^["](.*)["]$/g
        downloadElement.style.display = 'none'
        downloadElement.href = href
        downloadElement.download = decodeURI(filename.replace(reg, '$1')) // 下载后文件名
        document.body.appendChild(downloadElement)
        downloadElement.click() // 点击下载
        document.body.removeChild(downloadElement) // 下载完成移除元素
        window.URL.revokeObjectURL(href)
      },
      /**
       * 清空table选中
       */
      clearSelected() {
        this.loading = true
        // ajax request after empty completing
        setTimeout(() => {
          this.loading = false
          this.$refs.table.clearSelected()
        }, 200)
      },
      /**
       * 记录可翻页的选中行
       * @param selectedRowKeys
       * @param selectedRows
       */
      onSelectChange(selectedRowKeys, selectedRows) {
        this.selectedRowKeys = selectedRowKeys
        selectedRows = selectedRows.concat(this.selectedRows.filter(oldRow => { // 拼接去重后的选中行,得到所有选中行,包含
          const hasRow = selectedRows.find(row => oldRow.id === row.id)
          return !hasRow
        })).filter(row => { // 过滤掉所有选中行中将选中改为未选中的行
          const item = this.selectedRowKeys.find(rowKey => rowKey === row.id)
          return item
        })
        this.selectedRows = selectedRows
        this.$refs.table.updateSelect(selectedRowKeys, selectedRows)
      }
    }
  }
</script>
<style lang="less">
  .table-operator {
    margin-bottom: 18px;
  }

  button {
    margin-right: 8px;
  }

  .file-tool {
    display: flex;
    flex-direction: column;

    .path-tool {
      margin-top: 12px;
    }
  }
</style>
