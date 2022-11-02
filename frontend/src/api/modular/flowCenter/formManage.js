import { axios } from '@/utils/request'

/**
 * 获取表单列表
 *
 * @author MonsterUncle
 * @date 2022/1/17 17:59
 */
export function getFormList (parameter) {
  return axios({
    url: '/flcForm/list',
    method: 'get',
    params: parameter
  })
}
/**
 * 获取表单列表
 *
 * @author MonsterUncle
 * @date 2022/1/17 17:59
 */
export function getFormPage (parameter) {
  return axios({
    url: '/flcForm/page',
    method: 'get',
    params: parameter
  })
}

/**
 * 新增表单
 *
 * @author MonsterUncle
 * @date 2022/1/17 17:59
 */
export function flcFormAdd (parameter) {
  return axios({
    url: '/flcForm/add',
    method: 'post',
    data: parameter
  })
}

/**
 * 编辑表单
 *
 * @author MonsterUncle
 * @date 2022/1/17 17:59
 */
export function flcFormEdit (parameter) {
  return axios({
    url: '/flcForm/edit',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除表单
 *
 * @author MonsterUncle
 * @date 2022/1/17 17:59
 */
export function flcFormDelete (parameter) {
  return axios({
    url: '/flcForm/delete',
    method: 'post',
    data: parameter
  })
}
