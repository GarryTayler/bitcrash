<template>
  <div>
    <div class="flex-row root">
      <b-row align-v="start" class="flex1 content-padding main-content">
        <b-col sm="12" md="4" lg="4" xl="4" class="p-none m-b">
          <bots-table :type="0" :fields="bots_tbl_fields" :items="current_users" class="m-b" />
          <bots-table :type="1" :fields="bots_cashout_tbl_fields" :items="cashout_list" />
        </b-col>
        <b-col sm="12" md="8" lg="8" xl="8" class="p-none p-l">
          <bit-crash-card class="m-b">
            <div slot="header" class="card-header">
              <b-row align-v="center">
                <b-col v-for="element in headerList" :key="element.id" sm="4" md="3" lg="3" xl="3" style="padding-left: 0px !important; padding-right: 0px !important;">
                  <div>
                    <crash-header-item :data="element" />
                  </div>
                </b-col>
              </b-row>
              <!-- <div class="flex-space-between-vc" style="overflow: hidden">
                  <crash-header-item v-for="element in headerList" :key="element.id" :data="element"></crash-header-item>
                </div> -->
            </div>
            <div class="card-content">
              <b-row>
                <crash-graph :event-bus="eventBus" />
              </b-row>
              <b-row>
                <b-col sm="12" md="4" lg="4" xl="4" class="m-b">
                  <crash-edit v-model="bet_input" label="BET" sup="BTC" />
                </b-col>
                <b-col sm="12" md="4" lg="4" xl="4" class="m-b">
                  <crash-edit v-model="auto_cashout" label="AUTO CASHOUT" sup="X" />
                </b-col>
                <b-col sm="12" md="4" lg="4" xl="4">
                  <crash-bet-button :is-disabled="!is_logged_in" :text="betBtnText" :size="betBtnSize" @click="do_action" />
                </b-col>
              </b-row>
              <b-row>
                <b-col sm="12" md="8" lg="8" xl="8">
                  <crash-scale-item @click="scaleItemClick" />
                </b-col>
                <b-col sm="12" md="4" lg="4" xl="4">
                  <crash-bet-select />
                </b-col>
              </b-row>
            </div>
          </bit-crash-card>
          <bit-crash-card>
            <div slot="header" class="card-header flex-space-between-vc all-bets">
              <span>
                All Bets
              </span>
            </div>
            <div class="card-content">
              <bit-crash-table :fields="all_tbl_fields" :items="all_tbl_items" />
            </div>
          </bit-crash-card>
        </b-col>
      </b-row>
      <!-- <chat></chat> -->
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BotsTable from '@/components/bots/BotsTable.vue'
import BitCrashCard from '@/components/crashTable/BitCrashCard.vue'
import BitCrashTable from '@/components/crashTable/BitCrashTable.vue'
import CrashHeaderItem from '@/components/main/CrashHeaderItem.vue'
import CrashBetButton from '@/components/main/CrashBetButton.vue'
import CrashBetSelect from '@/components/main/CrashBetSelect.vue'
import CrashEdit from '@/components/main/CrashEdit.vue'
import CrashScaleItem from '@/components/main/CrashScaleItem.vue'
// import Chat from '@/components/chat/Chat.vue'
import CrashGraph from '@/components/main/CrashGraph.vue'

import io from 'socket.io-client/dist/socket.io.js'
// import { getNumberFormat, showToast } from '@/utils'
import { getNumberFormat, getFloat2Decimal } from '@/utils'
import { game_log } from '@/api/crash'

export default {
  name: 'Home',
  components: {
    BotsTable,
    BitCrashCard,
    BitCrashTable,
    CrashHeaderItem,
    CrashBetButton,
    CrashBetSelect,
    CrashEdit,
    CrashScaleItem,
    // Chat,
    CrashGraph
  },
  computed: {
    ...mapGetters([
      'is_logged_in',
      'wallet',
      'avatar',
      'crash_server_url',
      'user_id',
      'name',
      'token'
    ]),
    betting_time: function() {
      return Math.floor(this.timeLeft / 100) / 10
    }
  },
  watch: {
    current_users: {
      deep: true,
      handler(val) {
        var temp = val
        for (var i = 0; i < temp.length; i++) {
          temp[i]['show_user'] = {
            name: temp[i]['name'],
            url:
              temp[i]['avatar_small'] === undefined ||
              temp[i]['avatar_small'] === null
                ? ''
                : temp[i]['avatar_small']
          }
          temp[i]['id'] = temp[i]['user_id']
        }
        this.updateAllBets()
      }
    },
    cashout_list: {
      deep: true,
      handler(val) {
        var temp = val
        for (var i = 0; i < temp.length; i++) {
          temp[i]['show_user'] = {
            name: temp[i]['name'],
            url:
              temp[i]['avatar_small'] === undefined ||
              temp[i]['avatar_small'] === null
                ? ''
                : temp[i]['avatar_small']
          }
          temp[i]['id'] = temp[i]['user_id']
        }
        this.updateAllBets()
      }
    }
  },
  data() {
    return {
      bots_tbl_fields: [
        {
          id: 1,
          label: 'User Name',
          type: 'profile',
          key: 'show_user'
        },
        {
          id: 2,
          label: 'Bet Amount',
          type: 'bet',
          key: 'bet'
        }
      ],
      bots_cashout_tbl_fields: [
        {
          id: 1,
          label: 'Username',
          type: 'profile',
          key: 'show_user'
        },
        {
          id: 2,
          label: '@',
          type: 'text',
          key: 'cashout'
        },
        {
          id: 3,
          label: 'Profit',
          type: 'text',
          key: 'option'
        }
      ],
      all_tbl_fields: [
        {
          id: 1,
          label: 'User',
          type: 'profile',
          key: 'user'
        },
        {
          id: 2,
          label: '@',
          type: 'text',
          key: 'type'
        },
        {
          id: 3,
          label: 'My Bet',
          type: 'text',
          key: 'mybet'
        },
        {
          id: 4,
          label: 'Bonus',
          type: 'text',
          key: 'bonus'
        },
        {
          id: 5,
          label: 'Profit',
          type: 'text',
          key: 'profit'
        }
      ],
      all_tbl_items: [
      ],
      headerList: [
      ],
      interval: 10,
      betBtnText: 'BET',
      betBtnSize: 'large',
      state: 'waiting', // there are three status, WAITING, STARTED, CRASHED
      bet_temp: 0, // for temporary save -- when game started, and you bet your bet is store in this variable
      bet_amount: 0, // real betting amount  when state becomes waiting, bet_amount = bet_temp and bet_temp becomes 0
      tick: 0,
      time_stamp: 0,

      bet_input: 0,
      auto_cashout: 0,
      auto_bet: false,

      current_users: [],
      cashout_list: [],

      game_id: 0,

      timeLeft: 5000,
      on_win: {
        return_base: true,
        increase_amount: 100
      },
      on_lose: {
        return_base: true,
        increase_amount: 100
      },
      timerHandler: 0,
      crash_socket: null,
      eventBus: {}
    }
  },
  created: function() {
    var self = this
    this.crash_socket = io.connect(this.crash_server_url)
    // socket reference

    this.crash_socket.on('onMessage', function(data) {
      switch (data.code) {
        case 'GameRule': // i don't know what to do here ...
          break
        case 'ReloadPlayers':
          console.log('ReloadPlayers')
          self.reload(data)
          // self.addHistory(data)
          // recalc bet_sum, cashout_sum, and add count-up/down animation ...
          break
        case 'WaitGame':
          // $('title').html('Crash | Tarobet')
          // game-created
          self.sendEvent('game-created', { duration: 0 })

          self.on_wait(data)
          break
        case 'GameStart':
          // emit game-started
          self.start(data)
          break
        case 'Tick':
          // from server
          if (Date.now() - self.time_stamp > 500) {
            // $('title').html(
            //   parseFloat(data.tick / 100).toFixed(2) + 'x - Crash | Tarobet'
            // )
            self.time_stamp = Date.now()
          }
          self.do_tick(data.tick)
          break
        case 'GameCrash':
          // game finished
          self.crash(data)
          break
        case 'GameStartCrash':
          data.finish = 1
          self.start(data)

          self.sendEvent('game-finished', { crash: data.crash })

          self.close_timer()
          self.state = 'CRASHED'

          self.tick = data.crash
          self.update_btn()
          break
        case 'BetResult':
          if (data.status) {
            // update_wallet()
            self.$store.dispatch('user/getInfo', self.token)
          } else {
            // showToast('error', data.error)
          }
          break
        case 'Cashout':
          // the result of cashout
          if (data.status) {
            // update_wallet()
            self.$store.dispatch('user/getInfo', self.token)
          } else {
            // showToast('error', data.error)
          }
          break
        default:
          console.log('unknown code: ' + data.code)
      }
    })

    this.crash_socket.on('disconnect', function() {
      // showToast('error', 'Game server might have network problem. Please check  your interent connection.')
      // stop game
      self.stop()
    })
    this.updateHistory(null)
  },
  methods: {
    scaleItemClick(item) {
      if (this.bet_input == null) {
        this.bet_input = 0
      }
      this.bet_input = parseFloat(this.bet_input)
      switch (item.id) {
        case 0:
          this.bet_input = 0
          break
        case 1:
          this.bet_input += 10
          break
        case 2:
          this.bet_input += 100
          break
        case 3:
          this.bet_input += 250
          break
        case 4:
          this.bet_input += 1000
          break
        case 5:
          this.bet_input = Math.trunc(this.bet_input / 2)
          break
        case 6:
          this.bet_input = Math.trunc(this.bet_input * 2)
          break
        case 7:
          this.bet_input = this.wallet
          break
        default:
      }
    },
    updateHistory(data) {
      game_log({ limit: 4 }).then(response => {
        this.headerList = []
        const { data } = response
        for (var i = 0; i < data.length; i++) {
          this.headerList.push(
            {
              id: data[i].GAMENO,
              scale: getFloat2Decimal(data[i].BUST / 100),
              val: data[i].GAMENO,
              type: 0,
              is_active: true
            }
          )
        }
      })
      // if (data.crash !== undefined && data.crash && data.game_no !== undefined && data.game_no) {
      //   var crash = isNaN(parseFloat(data.crash)) ? 0 : parseFloat(data.crash)
      //   var game_no = isNaN(parseFloat(data.game_no)) ? 0 : parseFloat(data.game_no)
      //   if (this.headerList.length === 4) {
      //     this.headerList.shift()
      //   }
      //   this.headerList.push(
      //     {
      //       id: game_no,
      //       scale: getFloat2Decimal(crash / 100),
      //       val: game_no,
      //       type: 0,
      //       is_active: true
      //     }
      //   )
      // }
    },
    do_action() {
      if (!this.is_logged_in) return
      if (this.bet_temp > 0) this.bet_temp = 0
      else if (this.bet_amount > 0) {
        // cancel current bet
        if (this.state === 'WAITING') return // when waiting status, you can do nothing but bet...
        if (this.state === 'STARTED') {
          if (this.crash_socket != null) {
            this.crash_socket.emit('onMessage', {
              code: 'CashOut',
              user_id: this.user_id,
              game_id: this.game_id,
              stopped_at: this.tick
            })
          }
          this.bet_amount = 0
        }
      } else {
        // place bet
        var t_bet = parseInt(this.bet_input)
        if (isNaN(t_bet) || t_bet === 0) {
          // invalid inputs
          // showToast('error', 'Please input correct number.')
          return
        }
        if (this.state === 'WAITING') {
          this.bet_amount = t_bet
          this.do_bet()
        } else {
          // when it's after started, then ...
          this.bet_temp = t_bet
        }
      }
      this.update_btn()
    },
    update_btn() {
      console.log('update btn', this.bet_temp, this.bet_amount)
      var label = 'BET'
      if (this.bet_temp > 0) label = 'Cancel'
      else if (this.bet_amount > 0) {
        if (this.state === 'WAITING') label = 'Cancel'
        else if (this.state === 'STARTED') {
          label = 'Cashout '
          var cashVal = getNumberFormat(this.bet_amount * this.tick / 100)
          if (cashVal.length > 5) label += '@'

          if (cashVal.length > 9) {
            this.betBtnSize = 'small'
          } else {
            this.betBtnSize = 'large'
          }
          label += ' ' + cashVal
        }
      }
      // if (label == 'Place Bet' || label == 'Cancel') {
      //   $('.btn-place-bet').removeClass('cashout')
      // } else {
      //   $('.btn-place-bet').addClass('cashout')
      // }

      this.betBtnText = label
    },
    init_timer() {
      if (this.timerHandler) return
      this.timerHandler = setInterval(this.intervalFunc, this.interval)
    },
    close_timer() {
      if (this.timerHandler === 0) return
      clearInterval(this.timerHandler)
      this.timerHandler = 0
    },
    intervalFunc() {
      this.sendEvent('game-created', { duration: this.timeLeft })
      this.timeLeft -= this.interval
      if (this.timeLeft <= 0) {
        clearInterval(this.timerHandler)
        this.timerHandler = 0
      }
      // now we get start signal from node server, we don't need to do sth
    },
    on_wait(data) {
      this.timeLeft = data.time_left
      this.state = 'WAITING'
      this.game_id = data.game_id
      this.reload({
        current_users: data.current_users,
        cashout_list: []
      })
      this.init_timer()

      // here ... we make bet if bet_temp is no 0
      if (this.bet_temp > 0) {
        // real bet here ...
        this.bet_amount = this.bet_temp
        this.bet_temp = 0 // now, we set bet_temp = 0 for next round
        this.do_bet()
      }
      this.update_btn()
    },
    do_bet() {
      this.crash_socket.emit('onMessage', {
        code: 'addBet',
        user_id: this.user_id,
        game_id: this.game_id,
        bet: this.bet_amount,
        // extra info
        user_name: this.name,
        avatar: this.avatar
      })
    },
    do_tick(tick) {
      if (this.state !== 'STARTED') {
        this.start({ tick: tick })
      } else {
        this.tick = tick
        if (this.bet_amount > 0) this.update_btn() // then you need to show cashout
      }
    },
    reload(data) {
      this.current_users = data.current_users
      this.cashout_list = data.cashout_list
      if (!this.is_logged_in) return
      for (var i = 0; i < this.current_users.length; i += 1) {
        if (
          this.current_users[i].is_bot === 0 &&
          this.current_users[i].user_id === this.user_id
        ) {
          this.bet_amount = this.current_users[i].bet
          break
        }
      }
      console.log('on reload')
      this.update_btn()
    },
    crash(data) {
      this.state = 'CRASHED'
      this.tick = data.crash
      if (this.bet_amount > 0) {
        // you loose money ...
        // update_wallet()
        this.$store.dispatch('user/getInfo', this.token)
      }
      this.bet_amount = 0
      this.sendEvent('game-finished', { crash: this.tick })
      this.update_btn()

      this.updateHistory(data)
      // $('title').html('Crashed at ' + this.tick / 100 + 'x - Crash | Tarobet')
    },
    start(data) {
      this.close_timer()
      // when game starts, it's tick will be zero
      this.tick = data.tick
      this.time_stamp = Date.now()
      // if betted, then he can cashout
      if (data.finish) {
        // on startfinish, i mean finished at 1x
        this.state = 'CRASHED'
        this.sendEvent('game-finished', { crash: this.tick })
        // $('title').html('Crashed at 1x - Crash | Tarobet')
      } else {
        this.state = 'STARTED'
        this.sendEvent('game-started', { crash: this.tick })
      }

      this.update_btn()
    },
    stop() {
      this.sendEvent('game-error', {})
    },
    sendEvent(msg, data) {
      this.eventBus = {
        msg: msg,
        payload: data
      }
    },
    updateAllBets() {
      this.all_tbl_items = []
      for (var i = 0; i < this.current_users.length + this.cashout_list.length; i++) {
        var list = []
        var index = 0
        if (i < this.current_users.length) {
          list = this.current_users
          index = i
        } else {
          list = this.cashout_list
          index = i - this.current_users.length
        }
        var data = {}
        data['id'] = list[index]['user_id']
        data['user'] = {
          name: list[index]['name'],
          url:
            list[index]['avatar_small'] === undefined ||
            list[index]['avatar_small'] === null
              ? ''
              : list[index]['avatar_small']
        }
        data['type'] = isNaN(parseFloat(list[index]['cashout'])) ? '-' : getFloat2Decimal(parseFloat(list[index]['cashout']))
        data['mybet'] = list[index]['bet']
        data['bonus'] = '-'
        data['profit'] = isNaN(parseFloat(list[index].option)) ? '-' : getFloat2Decimal((parseFloat(list[index].option) / 100 - 1) * data.mybet)
        this.all_tbl_items.push(data)
      }
    }
  }
}
</script>
<style lang="scss" scoped>
@import "~@/assets/scss/_variables.scss";
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
.root {
  position: relative;
  width: 100%;
}
.main-content {
  width: 100%;
}
.content-padding {
  padding-left: 50px;
  padding-top: 50px;
  padding-right: calc(50px + #{$chat-width} + #{$scrollbar-width});
  @include media-breakpoint-down(md) {
    padding-right: 50px;
  }
  padding-bottom: 50px;

  .p-l {
    // padding-left: 20px;
    // @include media-breakpoint-down(xs) {
    //   padding-left: 0px;
    // }
  }
}

.card-header {
  min-height: $card-header-height;
  background: $crash-header-bg-color;
  padding-left: 20px;
  padding-right: 20px;
  padding-bottom: 15px;
  padding-top: 15px;
}
.card-content {
  padding: 35px;
}
.m-b {
  margin-bottom: $normal-margin-bottom-sm;
}
.all-bets {
  color: white;
}
</style>
