<template>
  <div class="dropdown">
    <button class="dropbtn flex-row-hl-vc p-l-r" @click="showDropDown()">
      <img class="profile-img" alt="avatar" src="@/assets/img/IMAGE_C.png">
      <div class="m-l" style="text-align: left;">
        <div class="profile-name">{{ avatarName }}</div>
        <div class="bit-text">bits {{ avatarBits }}</div>
      </div>
      <font-awesome-icon class="down m-l" icon="chevron-down" />
    </button>
    <!-- <div class="dropbtn flex-row-hl-vc p-l-r" @click="showDropDown()">
      <img class="profile-img" alt="avatar" src="@/assets/img/IMAGE_C.png"/>
      <div class="m-l">
          <div class="profile-name">{{avatarName}}</div>
          <div class="bit-text">bits {{avatarBits}}</div>
      </div>
      <font-awesome-icon class="down m-l" icon="chevron-down" />
    </div> -->
    <div id="dropdownList" class="dropdown-content">
      <div v-for="item in items" :key="item.id" class="dropdown-item" @click="onItemClick(item.id)">
        {{ item.lbl }}
      </div>
    </div>
  </div>
</template>

<script>
// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName('dropdown-content')
    var i
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i]
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show')
      }
    }
  }
}
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
  color: $navbar-profile-text-color;
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

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: $main-bg-color;
  min-width: 160px;
  width: 100%;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content {
  .dropdown-item {
    color: white;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    cursor: pointer;
    &:hover {
      background-color: #384779;
    }
  }
}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {
  display: block;
}
</style>
