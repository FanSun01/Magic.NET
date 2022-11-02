import { axios } from '@/utils/request'

/**
 * 查询我收到的系统通知公告
 *
 * @author yubaoshan
 * @date 2020/7/3 03:02
 */
export function sysNoticeReceived (parameter) {
  return axios({
    url: '/sysNotice/received',
    method: 'get',
    params: parameter
  })
}

export function unReadNotice (parameter) {
  return axios({
    url: '/sysNotice/unread',
    method: 'get',
    params: parameter
  })
}

