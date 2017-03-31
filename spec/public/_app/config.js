(function() {
  var define_api, host;

  this.App = this.App || {};

  host = document.location.href || "";

  define_api = function(host) {
    if (host.match(/saveh.com.br/)) {
      return '//webapi.saveh.com.br/api';
    } else {
      return '//dapisaveh.eokoe.com/api';
    }
  };

  this.App.config = {
    DEBUG: false,
    API_BASE: define_api(host),
    CORS: true
  };

}).call(this);
