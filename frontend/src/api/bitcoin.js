import request from '@/utils/request'

export function get_deposit_address(data) {
  return request({
    url: 'api/btc/get_deposit_address',
    method: 'post',
    data
  })
}

export function requestWithdraw(data) {
  return request({
    url: 'api/btc/withdraw_request',
    method: 'post',
    data
  })
}

export function confirmWithdraw(data) {
  return request({
    url: 'api/btc/withdraw_confirm',
    method: 'post',
    data
  })
}

export function getWithdrawList(data) {
  return request({
    url: 'api/btc/withdraw_log',
    method: 'post',
    data
  })
}
