<template>
    <a  @click="logEvent"><i class="fas fa-shopping-cart" :class="yellow"  ></i></a>
</template>

<script>
export default {
  name: "Cart",
  data: function() {
    return {
      clicked: false,
      index: 0,
      yellow: "",
      array: [],
      show: false
    };
  },
  methods: {
    logEvent(number) {
      this.clicked = !this.clicked;
      if (this.clicked === false) {
        this.yellow = "black-cart";
      } else {
        this.yellow = "yellow-cart";
      }
    }
  }
};
</script>

<style scoped>
</style>
