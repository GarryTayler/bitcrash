<template>
  <div class="flex-row-hl-vc">
    <div class="d-flex align-items-center m-b-5"  v-if="user_id!=data.user_id">
      <div class="icon p-r-15">
        <img src="@/assets/img/avatar-sample.png" />
        <!-- <img :src="user.url"/> -->
      </div>
      <div class="chat-text">
        <div class="chat-user">{{data.user}}</div>
        {{data.message}}
      </div>
    </div>
    <div class="d-flex align-items-center m-b-5" v-if="user_id==data.user_id">
      <div class="right-chat-text">
        <!-- <div class="chat-text"> -->
        {{ data.message }}
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ChatItem',
  props: {
    data: Object,
    default: function() {
      return {}
    }
  },
  computed: {
    ...mapGetters([
      'user_id',
      'token',
      'name',
      'wallet',
      'avatar'
    ])
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
  .p-l-r {
    padding-right: 10px;
  }
  .m-b-5 {
    margin-bottom: 10px;
  }
  img {
    width: 55px;
    border-radius: 10px;
  }
  .align-items-center{
    width: 100%;
  }
  .chat-user {
    color: #c1cedf;
  }
  .chat-text {
    border-radius: 5px;
    position: relative;
    padding: 17px 10px 17px 10px;
    background: #4b5e9a;
    border: 1px solid #4b5e9a;
    margin: 2px 0 0 15px;
    margin-right: -16px;
    color: white;
    width: 100%;
  }
  .chat-text:before {
    border-width: 6px;
    margin-top: -6px;
  }
  .chat-text:after {
    position: absolute;
    right: 100%;
    top: 15px;
    border: 8px solid transparent;
    border-right-color: #4b5e9a;
    content: ' ';
    height: 0;
    width: 0;
    pointer-events: none;
  }

  .right-chat-text:after{
    right: auto;
    left: 100%;
    border-right-color: transparent;
    border-left-color: #4b5e9a;
  }

  .right-chat-text {
    border-radius: 5px;
    position: relative;
    padding: 17px 10px 17px 10px;
    background: #4b5e9a;
    border: 1px solid #4b5e9a;
    margin-left: 70px;
    margin-right: -16px;
    color: white;
    width: 100%;
  }
</style>
