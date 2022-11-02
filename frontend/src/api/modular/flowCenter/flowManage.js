import { axios } from '@/utils/request'

/**
 * 查询流程管理
 *
 * @author MonsterUncle
 */
export function getFlcFlowschemePage (parameter) {
  return axios({
    url: '/flcFlowscheme/page',
    method: 'get',
    params: parameter
  })
}

/**
 * 流程管理列表
 *
 * @author MonsterUncle
 */
export function getFlcFlowschemeList (parameter) {
  return axios({
    url: '/FlcFlowscheme/list',
    method: 'get',
    params: parameter
  })
}

/**
 * 添加流程管理
 *
 * @author MonsterUncle
 */
export function flcFlowschemeAdd (parameter) {
  return axios({
    url: '/flcFlowscheme/add',
    method: 'post',
    data: parameter
  })
}

/**
 * 编辑流程管理
 *
 * @author MonsterUncle
 */
export function flcFlowschemeEdit (parameter) {
  return axios({
    url: '/flcFlowscheme/edit',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除流程管理
 *
 * @author MonsterUncle
 */
export function flcFlowschemeDelete (parameter) {
  return axios({
    url: '/flcFlowscheme/delete',
    method: 'post',
    data: parameter
  })
}
/**
 * 查询指定流程
 *
 * @author MonsterUncle
 */
 export function getFlcFlowscheme (parameter) {
  return axios({
    url: '/flcFlowscheme/detail',
    method: 'get',
    params: parameter
  })
}

