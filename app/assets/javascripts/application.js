//= require rails-ujs
//= require_tree .
new Vue({
  el: "#app",
  data: {
    clicked: false,
    index: 0
  },
  methods: {
    logEvent(e) {
      this.clicked = !this.clicked
      index++;
    }
  }

})