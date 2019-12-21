<template>
  <b-nav-item-dropdown right class="profile_menu_container">
    <template v-slot:button-content>
      <v-lazy-image :src="avatarImage" class="profile-img" />
      <div class="m-l">
        <div class="profile-name">{{ avatarName }}</div>
        <div class="bit-text">{{ avatarBits }}</div>
      </div>
    </template>
    <b-dropdown-item v-for="item in items" :key="item.id" href="#" @click="onItemClick(item.id)">
      {{ item.lbl }}
    </b-dropdown-item>
  </b-nav-item-dropdown>
</template>

<script>
// Close the dropdown menu if the user clicks outside of it
export default {
  name: 'ProfileSelect',
  components: {
  },
  props: {
    avatarUrl: {
      type: String,
      default: '@/assets/img/avatar-sample.png'
    },
    avatarName: {
      type: String,
      default: ''
    },
    avatarBits: {
      type: Number,
      default: 0
    },
    avatarImage: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      activeItem: 0,
      items: [
        {
          id: 0,
          lbl: 'Log Out'
        }
      ]
    }
  },
  methods: {
    showDropDown() {
      document.getElementById('dropdownList').classList.toggle('show')
    },
    onItemClick(id) {
      this.activeItem = id
      if (id === 0) {
        this.$store.dispatch('user/logout')
      }
    }
  }
}
</script>
<style lang="scss" scoped>
@import '~@/assets/scss/_variables.scss';
@import "~bootstrap/scss/bootstrap";
@import "~bootstrap-vue/src/index";

.profile_menu_container {
  .dropdown-menu {
    background: #4b5e9a;
    a {
      color: #fff;
      font-size: 0.8vw;
    }
    a:hover {
      background: transparent !important;
    }
  }
}

::v-deep .dropdown-menu {
   background: #4b5e9a;
   outline: none;
    a {
      color: #fff;
      font-size: 0.8vw;
      @include media-breakpoint-down(md) {
        font-size: 14px;
      }
    }
    a:hover {
      background: #384779 !important;
    }
}
::v-deep .dropdown-menu:hover {
  outline: none;
}

.m-l {
  margin-left: 15px;
}
.profile-name {
  color: $navbar-text-color;
  font-size: $navbar-text-size;
  font-weight: bold;
  max-width: 200px;
}
.p-l-r {
  padding-left: 10px;
  padding-right: 10px;
}
.bit-text {
  color: #fdd233;
  font-size: $navbar-text-size;
  font-weight: bold;
  margin-top: 5px;
}
.down {
  color: $navbar-text-color;
}
// Dropdown
.dropbtn {
  cursor: pointer;
  border: none;
  background: transparent;
  outline: none;
}

/* Dropdown button on hover & focus */
.dropbtn:hover,
.dropbtn:focus {
  background-color: rgba(0, 0, 0, 0.2);
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
  position: relative;
  display: inline-block;
}

</style>
