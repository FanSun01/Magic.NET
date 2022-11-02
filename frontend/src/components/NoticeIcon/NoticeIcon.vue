<template>
  <a-popover
    v-model="visible"
    trigger="click"
    placement="bottomRight"
    overlayClassName="header-notice-wrapper"
    :getPopupContainer="() => $refs.noticeRef.parentElement"
    :autoAdjustOverflow="true"
    :arrowPointAtCenter="true"
    :overlayStyle="{ width: '300px', top: '50px' }"
  >
    <template slot="content">
      <a-spin :spinning="loading">
        <a-tabs>
          <a-tab-pane :tab="item.key" :key="item.key" v-for="item in userNotices.rows">
            <a-list
              ><a-list-item
                v-for="(notice, index) in item.noticeData.filter(m => {
                  return m.type == item.value
                })"
                :key="index"
              >
                <a-list-item-meta :title="notice.title" :description="notice.publicTime">
                  <a-avatar style="background-color: white" slot="avatar" :src="noticeImg" />
                </a-list-item-meta>
              </a-list-item>
              <a-list-item
                v-if="
                  item.noticeData.filter(m => {
                    return m.type == item.value
                  }).length > 0
                "
                style="display: block;text-align: center;"
              >
                <a-button type="link" @click="goMore()">去处理</a-button>
              </a-list-item>
            </a-list>
          </a-tab-pane>
        </a-tabs>
      </a-spin>
    </template>
    <span @click="fetchNotice" class="header-notice" ref="noticeRef" style="padding: 0 18px">
      <a-badge :count="userNotices.totalRows">
        <a-icon style="font-size: 16px; padding: 4px" type="bell" />
      </a-badge>
    </span>
  </a-popover>
</template>

<script>
import noticeImg from '../../assets/notice.png'
import { mapGetters } from 'vuex'
export default {
  name: 'HeaderNotice',
  data() {
    return {
      loading: false,
      visible: false,
      noticeImg: noticeImg
    }
  },
  mounted() {},
  computed: {
    ...mapGetters(['userNotices'])
  },
  methods: {
    fetchNotice() {
      // if (!this.visible) {
      //   this.loading = true
      //   setTimeout(() => {
      //     this.loading = false
      //   }, 100)
      // } else {
      //   this.loading = false
      // }
      this.visible = !this.visible
    },
    goMore() {
      this.visible = !this.visible
      this.$router.push('/noticeReceived')
    }
  }
}
</script>

<style lang="css">
.header-notice-wrapper {
  top: 50px !important;
}
</style>
<style lang="less" scoped>
.header-notice {
  display: inline-block;
  transition: all 0.3s;

  span {
    vertical-align: initial;
  }
}
</style>
