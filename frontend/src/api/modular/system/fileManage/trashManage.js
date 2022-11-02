import { axios } from '@/utils/request'

/**
 * 查询回收站
 *
 * @author 胡国东
 */
export function TrashPage (parameter) {
  return axios({
    url: '/Trash/page',
    method: 'get',
    params: parameter
  })
}

/**
 * 回收站列表
 *
 * @author 胡国东
 */
export function TrashList (parameter) {
  return axios({
    url: '/Trash/list',
    method: 'get',
    params: parameter
  })
}

/**
 * 添加回收站
 *
 * @author 胡国东
 */
export function TrashAdd (parameter) {
  return axios({
    url: '/Trash/add',
    method: 'post',
    data: parameter
  })
}

/**
 * 编辑回收站
 *
 * @author 胡国东
 */
export function TrashEdit (parameter) {
  return axios({
    url: '/Trash/edit',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除回收站
 *
 * @author 胡国东
 */
export function TrashDelete (parameter) {
  return axios({
    url: '/Trash/delete',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除回收站
 *
 * @author 胡国东
 */
export function TrashDeletes (parameter) {
  return axios({
    url: '/Trash/deletes',
    method: 'post',
    data: parameter
  })
}

/**
 * 恢复
 *
 * @author 胡国东
 */
export function TrashRecover (parameter) {
  return axios({
    url: '/Trash/recover',
    method: 'post',
    data: parameter
  })
}

/**
 * 恢复多个
 *
 * @author 胡国东
 */
export function TrashRecovers (parameter) {
  return axios({
    url: '/Trash/recovers',
    method: 'post',
    data: parameter
  })
}

/**
 * 清空
 *
 * @author 胡国东
 */
export function TrashEmpty (parameter) {
  return axios({
    url: '/Trash/empty',
    method: 'post',
    data: parameter
  })
}

