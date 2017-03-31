(function() {
  this.App = this.App || {};

  this.Application = (function() {
    function Application() {}

    Application.init = function() {
      var $body, act, ctrl, e, ns, ref;
      try {
        ref = this._get_vars(), $body = ref[0], ctrl = ref[1], act = ref[2];
        ns = App.Controller;
        if (ns[ctrl] && ns[ctrl][act] && 'function' === typeof ns[ctrl][act]) {
          return new App.Controller[ctrl][act]({
            controller: ctrl,
            action: act
          });
        }
      } catch (error) {
        e = error;
        return console.error(e);
      }
    };

    Application._get_vars = function() {
      var $body;
      $body = $(document.body);
      return [$body, $body.data('controller'), $body.data('action') || 'index'];
    };

    return Application;

  })();

}).call(this);
