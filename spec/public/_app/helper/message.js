(function() {
  this.message = function(title, message, options) {
    if (options == null) {
      options = {};
    }
    if (typeof swal !== 'undefined') {
      if (title && !message) {
        swal(title);
      }
      if (title && message) {
        return swal(title, message);
      }
    } else {
      return alert(title);
    }
  };

}).call(this);
