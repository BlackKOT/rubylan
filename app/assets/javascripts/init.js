//= require paginate
console.log( '[init] app' );

var app = new Vue({
  el: '#app',
  components: {
      'paginate': VComponents.paginate
  },
  methods: {
    clickCallback: function(pageNum) {
      console.log(pageNum)
    }
  },
});