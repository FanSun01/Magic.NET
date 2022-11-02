import { axios } from '@/utils/request'

/**
 * 查询文档
 *
 * @author 胡国东
 */
export function DocumentPage (parameter) {
  return axios({
    url: '/Document/page',
    method: 'get',
    params: parameter
  })
}

/**
 * 文档列表
 *
 * @author 胡国东
 */
export function DocumentList (parameter) {
  return axios({
    url: '/Document/list',
    method: 'get',
    params: parameter
  })
}

/**
 * 文件树
 *
 * @author 胡国东
 */
export function DocumentTree (parameter) {
  return axios({
    url: '/Document/tree',
    method: 'get',
    params: parameter
  })
}

/**
 * 添加文档
 *
 * @author 胡国东
 */
export function DocumentAdd (parameter) {
  return axios({
    url: '/Document/add',
    method: 'post',
    data: parameter
  })
}

/**
 * 编辑文档
 *
 * @author 胡国东
 */
export function DocumentEdit (parameter) {
  return axios({
    url: '/Document/edit',
    method: 'post',
    data: parameter
  })
}

/**
 * 删除文档
 *
 * @author 胡国东
 */
export function DocumentDelete (parameter) {
  return axios({
    url: '/Document/delete',
    method: 'post',
    data: parameter
  })
}

/**
 * 批量删除文档
 *
 * @author 胡国东
 */
export function DocumentDeletes (parameter) {
  return axios({
    url: '/Document/deletes',
    method: 'post',
    data: parameter
  })
}


/**
 * 批量移动文档
 *
 * @author 胡国东
 */
export function DocumentMove (parameter) {
  return axios({
    url: '/Document/move',
    method: 'post',
    data: parameter
  })
}

export function DocumentUpload (parameter) {
  return axios({
    url: '/Document/upload',
    method: 'post',
    data: parameter
  })
}

export function DocumentUploadFolder (parameter) {
  return axios({
    url: '/Document/uploadfolder',
    method: 'post',
    data: parameter
  })
}

/**
 * 下载文件
 */
export function DocumentDownload (parameter) {
  return axios({
    url: '/Document/download',
    method: 'get',
    params: parameter,
    responseType: 'blob'
  })
}


/**
 * 查看图片
 *
 * @author yubaoshan
 * @date 2020/6/30 00:20
 */
export function DocumentPreview (parameter) {
  return axios({
    url: '/Document/preview',
    method: 'get',
    params: parameter,
  })
}