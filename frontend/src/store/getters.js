const getters = {
  sidebar: state => state.app.sidebar,
  size: state => state.app.size,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  avatar_small: state => state.user.avatar_small,
  avatar_medium: state => state.user.avatar_medium,
  name: state => state.user.name,
  ipaddress: state => state.user.ipaddress,
  introduction: state => state.user.introduction,
  roles: state => state.user.roles,
  wallet: state => state.user.wallet,
  is_logged_in: state => state.user.token !== undefined && state.user.token !== '',
  user_id: state => state.user.user_id,
  crash_server_url: state => state.app.crash_server_url,
  chat_server_url: state => state.app.chat_server_url,
  crash_chat: state => state.app.crash_chat
}
export default getters
