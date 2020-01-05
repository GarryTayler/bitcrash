import request from '@/utils/request'

export function get_deposit_address(data) {
  return request({
    url: 'api/btc/get_deposit_address',
    method: 'post',
    data
  })
}

