<template>
  <a-modal
    title="租户授权菜单"
    :width="600"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleSubmit"
    @cancel="handleCancel"
  >
    <a-spin :spinning="formLoading">
      <a-form :form="form">
        <a-form-item label="应用名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
          <a-select @change="appChange" v-model="selectValue">
            <a-select-option v-for="(item, index) in appList" :key="index" :value="item.appCode">{{
              item.appName
            }}</a-select-option>
          </a-select>
        </a-form-item>
        <a-form-item label="菜单权限" :labelCol="labelCol" :wrapperCol="wrapperCol" class="grantMenuScrollbar">
          <a-tree
            v-model="checkedKeys"
            multiple
            checkable
            :auto-expand-parent="autoExpandParent"
            :expanded-keys="expandedKeys"
            :tree-data="menuTreeData"
            :selected-keys="selectedKeys"
            :replaceFields="replaceFields"
            @expand="onExpand"
            @check="onCheck"
          />
        </a-form-item>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
import { SysMenuTreeForGrant } from '@/api/modular/system/menuManage'
import { sysTenantOwnMenu, sysTenantGrantMenu } from '@/api/modular/system/tenantManage'

export default {
  data() {
    return {
      labelCol: {
        style: {
          'padding-right': '20px',
        },
        xs: {
          span: 24,
        },
        sm: {
          span: 5,
        },
      },
      wrapperCol: {
        xs: {
          span: 24,
        },
        sm: {
          span: 15,
        },
      },
      menuTreeData: [],
      expandedKeys: [],
      checkedKeys: [],
      halfCheckedKeys: [],
      visible: false,
      confirmLoading: false,
      formLoading: true,
      autoExpandParent: true,
      selectedKeys: [],
      subValues: [],
      tenantEntity: [],
      replaceFields: {
        key: 'id',
      },
      form: this.$form.createForm(this),
      commitKeys: [],
      leastChild: [],
      appList: [],
      menuList: [],
      selectValue: null,
    }
  },

  methods: {
    // 初始化方法
    tenantMenu(record) {
      this.formLoading = true
      this.tenantEntity = record
      this.visible = true
      // 获取菜单列表
      SysMenuTreeForGrant().then((res) => {
        if (res.success) {
          this.appList = res.data.appList
          this.menuList = res.data.menuTree
          this.selectValue=this.appList[0].appCode
          // 此租户已有菜单权限
          sysTenantOwnMenu({
            id: record.id,
          }).then((res) => {
            if (res.success) {
              this.commitKeys = res.data
              if (this.selectValue) {
                this.appChange(this.selectValue)
              }
            }
            this.formLoading = false
          })
        }
      })
    },
    appChange(value) {
      this.formLoading = true
      this.selectValue = value
      let menuList = this.menuList.filter((f) => f.appCode == value)
      this.menuTreeData = menuList
      this.getLeastChild(menuList)
      // 默认展开目录级
      this.expandedKeys = []
      menuList.forEach((item) => {
        this.expandedKeys.push(item.id)
      })
      let menuInfo = this.commitKeys.find((f) => f.appCode == value)
      if (!menuInfo) {
        menuInfo = {
          appCode: value,
          menuIdList: [],
        }
        this.commitKeys.push(menuInfo)
      }
      this.pickCheckedKeys(menuInfo.menuIdList)
      this.formLoading = false
    },
    getLeastChild(data) {
      data.forEach((item) => {
        this.pushLeastChild(item)
      })
    },
    pushLeastChild(e) {
      if (e.children.length > 0) {
        this.getLeastChild(e.children)
        return
      }
      this.leastChild.push(e.id)
    },
    pickCheckedKeys(data) {
      data.forEach((item) => {
        if (this.leastChild.includes(item)) {
          this.checkedKeys.push(item)
        }
      })
    },
    onExpand(expandedKeys) {
      this.expandedKeys = expandedKeys
      this.autoExpandParent = false
    },
    onCheck(checkedKeys, event) {
      this.checkedKeys = checkedKeys
      let index = this.commitKeys.findIndex((f) => f.appCode == this.selectValue)
      this.commitKeys[index].menuIdList = checkedKeys.concat(event.halfCheckedKeys)
    },
    handleSubmit() {
      const {
        form: { validateFields },
      } = this
      this.confirmLoading = true
      validateFields((errors, values) => {
        if (!errors) {
          let menuIdList = []
          this.commitKeys.forEach((item) => {
            item.menuIdList.forEach((menuId) => {
              menuIdList.push(menuId)
            })
          })
          sysTenantGrantMenu({
            id: this.tenantEntity.id,
            grantMenuIdList: menuIdList,
          })
            .then((res) => {
              if (res.success) {
                this.$message.success('授权成功')
                this.confirmLoading = false
                this.$emit('ok', values)
                this.handleCancel()
              } else {
                this.$message.error('授权失败：' + res.message)
              }
            })
            .finally((res) => {
              this.confirmLoading = false
            })
        } else {
          this.confirmLoading = false
        }
      })
    },
    handleCancel() {
      // 清空已选择的
      this.checkedKeys = []
      // 清空已展开的
      this.expandedKeys = []
      this.visible = false
    },
  },
}
</script>

<style scoped>
.grantMenuScrollbar {
  height: 60vh;
  overflow-y: auto;
}
</style>
