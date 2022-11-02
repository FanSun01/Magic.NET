import { axios } from '@/utils/request'

/**
 * 查询工作流
 *
 * @author MonsterUncle
 */
export function flowinstancePage (parameter) {
  return axios({
    url: '/flcFlowinstance/page',
    method: 'get',
    params: parameter
  })
}

/**
 * 工作流列表
 *
 * @author MonsterUncle
 */
export function flowinstanceList (parameter) {
  return axios({
    url: '/flcFlowinstance/list',
    method: 'get',
    params: parameter
  })
}

/**
 * 添加工作流
 *
 * @author MonsterUncle
 */
export function flowinstanceAdd (parameter) {
  return axios({
    url: '/flcFlowinstance/add',
    method: 'post',
    data: parameter
  })
}

/**
 * 编辑工作流
 *
 * @author MonsterUncle
 */
export function flowinstanceEdit (parameter) {
  return axios({
    url: '/flcFlowinstance/edit',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除工作流
 *
 * @author MonsterUncle
 */
export function flowinstanceDelete (parameter) {
  return axios({
    url: '/flcFlowinstance/delete',
    method: 'post',
    data: parameter
  })
}
/**
 * 撤销工作流
 *
 * @author MonsterUncle
 */
 export function flowinstanceCancel (parameter) {
  return axios({
    url: '/flcFlowinstance/cancel',
    method: 'post',
    data: parameter
  })
}
/**
 * 处理工作流
 *
 * @author MonsterUncle
 */
 export function flowinstanceVerification (parameter) {
  return axios({
    url: '/flcFlowinstance/verification',
    method: 'post',
    data: parameter
  })
}
/**
 * 工作流历史
 *
 * @author MonsterUncle
 */
 export function flowinstanceHistories (parameter) {
  return axios({
    url: '/flcFlowinstance/histories',
    method: 'post',
    data: parameter
  })
}
/**
 * 查询指定工作流
 *
 * @author MonsterUncle
 */
 export function getFlowinstance (parameter) {
  return axios({
    url: '/flcFlowinstance/detail',
    method: 'get',
    params: parameter
  })
}