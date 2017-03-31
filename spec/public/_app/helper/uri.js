(function() {
  "NAME\n  URI Helper\n\nDESCRIPTION\n  This helpers to get uri query string key/value\n\nSINOPSYS\n\n   params = URI.init().query()\n\nAUTHOR\n  Daniel Vinciguerra @dvinciguerra";
  this.URI = {
    _location: document.location.href || "",
    init: function(location) {
      if (location == null) {
        location = document.location.href;
      }
      this._location = location;
      return this;
    },
    absolute: function() {
      return this._location || document.location.href;
    },
    relative: function() {
      return document.location.pathname;
    },
    query: function() {
      var i, item, kv, len, list, params;
      list = window.location.search.substr(1).split('&');
      if (list === "") {
        return {};
      }
      params = {};
      for (i = 0, len = list.length; i < len; i++) {
        item = list[i];
        kv = item.split('=', 2);
        if (kv.length === 1) {
          params[kv[0]] = "";
        } else {
          params[kv[0]] = decodeURIComponent(kv[1].replace(/\+/g, " "));
        }
      }
      return params;
    }
  };

}).call(this);
