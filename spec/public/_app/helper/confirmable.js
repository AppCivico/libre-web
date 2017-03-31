(function() {
  var e;

  try {
    this.confirmable = function(options) {
      var cancel_cb, ok_cb;
      if (options == null) {
        options = {};
      }
      if (typeof swal !== 'undefined') {
        ok_cb = options.success || function() {};
        cancel_cb = options.cancel || function() {};
        options.showCancelButton = true;
        options.confirmButtonText = options.confirmButtonText || "OK";
        options.cancelButtonText = options.cancelButtonText || "Cancelar";
        if (!options.title) {
          options.title = options.text;
          delete options.text;
        }
        return swal(options, function(is_confirm) {
          if (is_confirm) {
            return ok_cb();
          } else {
            return cancel_cb();
          }
        });
      } else {
        if (confirm(options.text)) {
          return ok_cb();
        } else {
          return cancel_cb();
        }
      }
    };
  } catch (error) {
    e = error;
    console.error(e.message);
  }

}).call(this);
