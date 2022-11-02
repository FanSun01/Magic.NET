import { axios } from '@/utils/request'

export function getColumnInfoList (parameter) {
  return axios({
    url: '/dataBase/columnInfoList',
    method: 'get',
    params: parameter
  })
}

export function getTableInfoList () {
  return axios({
    url: '/dataBase/tableInfoList',
    method: 'get'
  })
}

export function tableAdd (parameter) {
  return axios({
    url: '/table/add',
    method: 'post',
    data: parameter
  })
}

export function tableEdit (parameter) {
  return axios({
    url: '/table/edit',
    method: 'post',
    data: parameter
  })
}

export function tableDelete (parameter) {
  return axios({
    url: '/table/delete',
    method: 'post',
    data: parameter
  })
}

export function columnAdd (parameter) {
  return axios({
    url: '/column/add',
    method: 'post',
    data: parameter
  })
}

export function columnEdit (parameter) {
  return axios({
    url: '/column/edit',
    method: 'post',
    data: parameter
  })
}

export function columnDelete (parameter) {
  return axios({
    url: '/column/delete',
    method: 'post',
    data: parameter
  })
}

export function createEntity (parameter) {
  return axios({
    url: '/table/createEntity',
    method: 'post',
    data: parameter
  })
}


