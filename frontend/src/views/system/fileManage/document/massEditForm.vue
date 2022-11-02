<template>
  <a-modal
    title="批量移动"
    :width="600"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
    :destroyOnClose="true">
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
        <a-form-item label="父级文件夹" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
          <a-tree-select
            v-decorator="['pId', {rules: [{ required: true, message: '请选择父级文件夹！' }]}]"
            style="width: 100%"
            :dropdownStyle="{ maxHeight: '300px', overflow: 'auto' }"
            :treeData="docTree"
            placeholder="请选择父级文件夹"
            treeDefaultExpandAll
            :replaceFields="replaceFields">
            <span slot="title" slot-scope="{ id }">{{ id }}
            </span>
          </a-tree-select>
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import {
    Empty
  } from 'ant-design-vue'
  import {
    DocumentTree,
    DocumentMove
  } from '@/api/modular/system/fileManage/documentManage'

  export default {
    data() {
      return {
        labelCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 6
          }
        },
        wrapperCol: {
          xs: {
            span: 24
          },
          sm: {
            span: 16
          }
        },
        docTree: [],
        replaceFields: {
          key: 'id',
          title: 'name',
          value: 'id'
        },
        pId: 0,
        data: [], // 批量编辑的数组
        visible: false,
        confirmLoading: false,
        form: this.$form.createForm(this),
      }
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
      // 初始化方法
      edit(data) {
        this.DocumentTree()
        this.visible = true
        this.data = data
      },
      /**
       * 移动文件
       */
      handleSubmit() {
        const { form: { validateFields } } = this
        this.confirmLoading = true
        validateFields((errors, values) => {
          if (!errors) {
            for (const key in values) {
              if (typeof (values[key]) === 'object') {
                values[key] = JSON.stringify(values[key])
              }
            }
            values.ids = this.data
            DocumentMove(values).then((res) => {
              if (res.success) {
                this.$message.success('批量移动成功')
                this.confirmLoading = false
                this.$emit('ok', values)
                this.handleCancel()
              } else {
                this.$message.error('批量移动失败:' + JSON.stringify(res.message))// + res.message
              }
            }).finally((res) => {
              this.confirmLoading = false
            })
          } else {
            this.confirmLoading = false
          }
        })
      },
      /**
       * 选中文件树
       * @param e 选中节点数组
       */
      handleClick(e) {
        this.pId = e[0]
      },
      handleCancel() {
        this.form.resetFields()
        this.visible = false
      }
    }
  }
</script>
