const getters = {
  sidebar: state => state.app.sidebar,
  size: state => state.app.size,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  introduction: state => state.user.introduction,
  roles: state => state.user.roles,
  wallet: state => state.user.wallet,
  is_logged_in: state => state.user.token !== undefined && state.user.token !== '',
  user_id: state => state.user.user_id,
  crash_server_url: state => state.app.crash_server_url
}
export default getters
