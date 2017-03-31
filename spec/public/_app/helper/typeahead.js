(function() {
  var autocomplete_matcher;

  if (this._datasets == null) {
    this._datasets = {};
  }

  this._datasets["default"] = [];

  autocomplete_matcher = function(list) {
    return function(q, cb) {
      var i, len, matches, str, substrRegex;
      matches = [];
      substrRegex = new RegExp(q, 'i');
      for (i = 0, len = list.length; i < len; i++) {
        str = list[i];
        if (substrRegex.test(str)) {
          matches.push(str);
        }
      }
      return cb(matches);
    };
  };

  this.Typeahead = {
    register: function(element, options, params) {
      var callback;
      if (options == null) {
        options = {};
      }
      if (params == null) {
        params = {};
      }
      return $(element).typeahead(callback = params.callback || autocomplete_matcher, options, {
        name: params.name,
        source: callback(params.dataset)
      });
    }
  };

}).call(this);
