<template>
  <button @click="logEvent" :class="yellow">
  </button>
</template>

<script>
export default {
  name: "Cart",
  data: function() {
    return {
      clicked: false,
      yellow: "not-clicked"
    };
  },
  methods: {
    logEvent(number) {
      this.clicked = !this.clicked;
      if (this.clicked === false) {
        this.yellow = "clicked";
      } else {
        this.yellow = "not-clicked";
      }
    }
  }
};
</script>

<style scoped>
</style>
