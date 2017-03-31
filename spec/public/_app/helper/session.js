(function() {
  var e;

  try {
    this.session = function() {
      if (typeof store !== 'undefined') {
        return store;
      } else {
        console.warn('Session storage lib is not present! Returning a simple and in-memory polyfill.');
        App._session = {};
        return {
          get: function(key) {
            return App._session[key];
          },
          set: function(key, value) {
            return App._session[key] = value;
          }
        };
      }
    };
  } catch (error) {
    e = error;
    console.log(e.message);
  }

}).call(this);
