import request from '@/utils/request'

export function login(data) {
  return request({
    url: 'api/user/login',
    method: 'post',
    data
  })
}

export function getInfo(data) {
  return request({
    url: 'api/user/info',
    method: 'post',
    data
  })
}

export function logout() {
  return request({
    url: 'api/user/logout',
    method: 'post'
  })
}

export function signup(data) {
  return request({
    url: 'api/user/signup',
    method: 'post',
    data
  })
}

export function fetchList(data) {
  return request({
    url: 'api/user/list',
    method: 'post',
    data
  })
}

export function updateUser(data) {
  return request({
    url: 'api/user/update',
    method: 'post',
    data
  })
}
