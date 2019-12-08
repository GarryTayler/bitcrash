<template>
  <div ref="chat" :class="{show:show}" class="chat-container">
    <div class="chat-background"/>
    <div class="chat">
      <div class="handle-button" :style="{'top':buttonTop+'px'}" @click="show=!show">
        <font-awesome-icon :icon="show?'chevron-right' : 'chevron-left'" />
      </div>
      <div class="chat-header flex-space-between-vc">
        Chat
        <nation-group-flag></nation-group-flag>
      </div>
      <div class="chat-items">
        <div class="drawer-container">
          <chat-item v-for="message in messages" :key="message.id" :data="message"></chat-item>
        </div>
      </div>
      <div class="chat-footer flex-space-between-vc">
        <chat-input-box :value="current_chat" :disabled="!is_logged_in" @sendMsg="sendMsg"></chat-input-box>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
// import { addClass, removeClass } from '@/utils'
import NationGroupFlag from '@/components/chat/NationGroupFlag.vue'
import ChatItem from '@/components/chat/ChatItem.vue'
import ChatInputBox from '@/components/chat/ChatInputBox.vue'
import io from 'socket.io-client/dist/socket.io.js'
import { emit, list } from '@/api/chat'

export default {
  name: 'Chat',
  components: {
    NationGroupFlag,
    ChatItem,
    ChatInputBox
  },
  props: {
    clickNotClose: {
      default: false,
      type: Boolean
    },
    buttonTop: {
      default: 250,
      type: Number
    }
  },
  computed: {
    ...mapGetters([
      'is_logged_in',
      'chat_server_url',
      'user_id',
      'name',
      'ipaddress',
      'token',
      'crash_chat',
      'avatar_small',
      'avatar_medium'
    ])
  },
  data() {
    return {
      show: true,
      messages: [
        {
          id: 1,
          user: 'Martintm33',
          user_id: 3,
          message: 'At least it wasnt catx'
        },
        {
          id: 2,
          user: 'da',
          user_id: 1,
          message: 'I wanna sau next big cat might go overb 10k'
        },
        {
          id: 4,
          user: 'Martintm33',
          user_id: 3,
          message: 'Morning and good luck!'
        },
        {
          id: 3,
          user: '23',
          user_id: 1,
          message: 'how are you all?'
        }
      ],
      current_chat: ''
    }
  },
  watch: {
    show(value) {
      if (value && !this.clickNotClose) {
        this.addEventClick()
      }
      //   if (value) {
      //     addClass(document.body, 'showChat')
      //   } else {
      //     removeClass(document.body, 'showChat')
      //   }
    }
  },
  mounted() {
    // this.insertToBody()
  },
  beforeDestroy() {
    const elx = this.$refs.chat
    elx.remove()
  },
  methods: {
    addEventClick() {
      window.addEventListener('click', this.closeSidebar)
    },
    closeSidebar(evt) {
      const parent = evt.target.closest('.chat')
      if (!parent) {
        this.show = false
        window.removeEventListener('click', this.closeSidebar)
      }
    },
    // insertToBody() {
    //   const elx = this.$refs.chat
    //   const body = document.querySelector('body')
    //   body.insertBefore(elx, body.firstChild)
    // }
    addChatItem(item) {
      // const { msg, username, curtime, type, avatar } = item

      // if (item.type === this.crash_chat) {
      // }
    },
    reload() {
      list({ type: this.crash_chat }).then(response => {
        if (response.data != null && response.data.length > 0) {
          this.messages = response.data
        }
      })
    },
    sendMsg(msg) {
      var emitData = {
        CHAT_TYPE: this.crash_chat,
        MSG: msg,
        IPADDRESS: this.ipaddress,
        USERID: this.user_id,
        AVATAR_MEDIUM: this.avatar_medium,
        AVATAR_SMALL: this.avatar_small,
        USERNAME: this.name
      }
      emit(emitData).then(response => {
        if (response.code !== 20000) {
          // Error
        } else {
          console.log(response.data)
          this.reload()
        }
      })

      this.current_chat = ''
    }
  },
  created: function() {
    var self = this
    this.chat_socket = io.connect(this.chat_server_url)
    // socket reference
    this.chat_socket.on('chat_message', function(item) {
      self.reload()
      // self.addChatItem(item)
    })
  }
}
</script>

<style>
/* .showChat {
  overflow: hidden
  position: relative
  width: calc(100% - 15px)
} */
</style>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.chat-container {
  height: 100%;
}
.chat-background {
  position: absolute;
  top: 0;
  left: 0;
  opacity: 0;
  @include media-breakpoint-up(md) {
    display: none;
  }
  @include media-breakpoint-down(md) {
    transition: opacity 0.3s cubic-bezier(0.7, 0.3, 0.1, 1);
  }
  background: rgba(0, 0, 0, 0.2);
}

.chat {
  width: 100%;
  width: calc(#{$chat-width} + #{$scrollbar-width});
  height: 100%;
  // position: absolute;
  right: 0;
  position: fixed !important;

  @include media-breakpoint-down(md) {
    transition: all 0.25s cubic-bezier(0.7, 0.3, 0.1, 1);
    transform: translate(100%);
  }
  box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.05);
  background: $navbar-bg-color;
  @include media-breakpoint-up(md) {
    position: absolute;
  }
}

.show {
  @include media-breakpoint-down(md) {
    transition: all 0.3s cubic-bezier(0.7, 0.3, 0.1, 1);
  }

  .chat-background {
    opacity: 1;
    @include media-breakpoint-up(md) {
      opacity: 0;
    }
    width: 100%;
    height: 100%;
  }

  .chat {
    @include media-breakpoint-down(md) {
      transform: translate(0);
    }
  }
}

.handle-button {
  width: 48px;
  height: 48px;
  position: absolute;
  left: -48px;
  text-align: center;
  font-size: 24px;
  border-radius: 6px 0 0 6px !important;
  pointer-events: auto;
  cursor: pointer;
  color: #fff;
  line-height: 48px;
  i {
    font-size: 24px;
    line-height: 48px;
  }
  @include media-breakpoint-up(md) {
    display: none;
  }
}
.chat-header {
  padding: 15px;
  background: $sidebar-header-bg-color;
  color: white;
  font-weight: bold;
}
.chat-items {
  padding-right: $scrollbar-width;
  height: calc(100% - 202px);
  overflow-y: auto;
  padding-bottom: 10px;
}
.drawer-container {
  padding: 24px;
  font-size: 14px;
  line-height: 1.5;
  word-wrap: break-word;

  .drawer-title {
    margin-bottom: 12px;
    color: rgba(0, 0, 0, 0.85);
    font-size: 14px;
    line-height: 22px;
  }

  .drawer-item {
    color: rgba(0, 0, 0, 0.65);
    font-size: 14px;
    padding: 12px 0;
  }

  .drawer-switch {
    float: right;
  }
}
.chat-footer {
  padding-left: 20px;
  padding-right: 20px;
}
</style>
