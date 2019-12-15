<template>
  <div>
    <div class="navbar-1 p-l-r">
      <hamburger v-if="device=='mobile'" id="hamburger-container" :is-active="sidebar.opened" class="hamburger-container" @toggleClick="toggleSideBar" />
      <a href="/" style="margin-left: 30px;">
        <img src="@/assets/img/brand_logo.png" class="logo-img">
        <h1 class="logo-title">BitCrash </h1>
      </a>
      <log-in-button v-if="is_admin_logged_in" text="LogOut" :size="true" class="logout" @click="logout" />
      <!-- <div class="right-menu" v-show="false">
        <template v-if="device!=='mobile'">
          <search id="header-search" class="right-menu-item" />

          <error-log class="errLog-container right-menu-item hover-effect" />

          <screenfull id="screenfull" class="right-menu-item hover-effect" />

          <el-tooltip content="Global Size" effect="dark" placement="bottom">
            <size-select id="size-select" class="right-menu-item hover-effect" />
          </el-tooltip>

        </template>

        <el-dropdown class="avatar-container right-menu-item hover-effect" trigger="click">
          <div class="avatar-wrapper">
            <img :src="avatar+'?imageView2/1/w/80/h/80'" class="user-avatar">
            <i class="el-icon-caret-bottom" />
          </div>
          <el-dropdown-menu slot="dropdown">
            <router-link to="/profile/index">
              <el-dropdown-item>Profile</el-dropdown-item>
            </router-link>
            <router-link to="/">
              <el-dropdown-item>Dashboard</el-dropdown-item>
            </router-link>
            <a target="_blank" href="https://github.com/PanJiaChen/vue-element-admin/">
              <el-dropdown-item>Github</el-dropdown-item>
            </a>
            <a target="_blank" href="https://panjiachen.github.io/vue-element-admin-site/#/">
              <el-dropdown-item>Docs</el-dropdown-item>
            </a>
            <el-dropdown-item divided>
              <span style="display:block;" @click="logout">Log Out</span>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div> -->
    </div>
    <div class="breadcrumb-wrapper">
      <breadcrumb id="breadcrumb-container" class="breadcrumb-container" />
    </div>
  </div>

</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/Breadcrumb'
import Hamburger from '@/components/Hamburger'
import LogInButton from '@/components/navbar/LogInButton'
// import ErrorLog from '@/components/ErrorLog'
// import Screenfull from '@/components/Screenfull'
// import SizeSelect from '@/components/SizeSelect'
// import Search from '@/components/HeaderSearch'

export default {
  components: {
    Breadcrumb,
    Hamburger,
    LogInButton
    // ErrorLog,
    // Screenfull,
    // SizeSelect,
    // Search
  },
  computed: {
    ...mapGetters([
      'is_admin_logged_in',
      'sidebar',
      // 'avatar',
      'device'
    ])
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch('app/toggleSideBar')
    },
    async logout() {
      await this.$store.dispatch('admin/logout')
      this.$router.push(`/login?redirect=${this.$route.fullPath}`)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";
@import "~@/assets/scss/_variables.scss";
.navbar-1 {
  height: 60px;
  overflow: hidden;
  position: relative;
  background: $crash-header-bg-color !important;
  // box-shadow: 0 1px 4px rgba(0,21,41,.08);
  // border-bottom: 1px solid #4c4d4d;
  color: white;

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background .3s;
    -webkit-tap-highlight-color:transparent;

    &:hover {
      background: rgba(0, 0, 0, .025)
    }
  }

  .errLog-container {
    display: inline-block;
    vertical-align: top;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background .3s;

        &:hover {
          background: rgba(0, 0, 0, .025)
        }
      }
    }

    .avatar-container {
      margin-right: 30px;

      .avatar-wrapper {
        margin-top: 5px;
        position: relative;

        .user-avatar {
          cursor: pointer;
          width: 40px;
          height: 40px;
          border-radius: 10px;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: absolute;
          right: -20px;
          top: 25px;
          font-size: 12px;
        }
      }
    }
  }
}

.breadcrumb-wrapper {
  height: 60px;
  overflow: hidden;
  position: relative;
  padding-left: 30px;
  @include media-breakpoint-down(md) {
    padding-left: 10px;
  }
  padding-right: 10px;
  background: $crash-header-bg-color !important;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);

  .breadcrumb-container {
    float: left;
  }
}
.logo-img {
  width: 32px;
  height: 32px;
  vertical-align: middle;
  margin-right: 12px;
}

.logo-title {
  display: inline-block;
  margin: 0;
  color: #fff;
  font-weight: 600;
  line-height: 50px;
  font-size: 25px;
  font-family: 'SF Slapstick Comic Oblique';//Avenir, Helvetica Neue, Arial, Helvetica, sans-serif;
  vertical-align: middle;
}
.p-l-r{
  padding-left: 10px;
  padding-right: 10px;
}
.logout {
  float: right;
}
</style>
