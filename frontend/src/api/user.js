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

export function getReferralData(data) {
  return request({
    url: 'api/user/get_user_referralcode',
    method: 'post',
    data
  })
}

export function getReferralValue(data) {
  return request({
    url: 'api/user/get_user_referral_value',
    method: 'post',
    data
  })
}

export function updateReferralValue(data) {
  return request({
    url: 'api/user/update_referral_value',
    method: 'post',
    data
  })
}

export function getWithdrawPageData(data) {
  return request({
    url: 'api/user/get_withdraw_page_data',
    method: 'post',
    data
  })
}
