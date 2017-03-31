(function() {
  this.stash = function(key, value, options) {
    var $el, $list;
    if (options == null) {
      options = {};
    }
    $el = options.root || document.body;
    $list = $($el).find("[data-model=" + key + "]");
    if ($list && $list.length > 0) {
      $list.html(value || "");
    }
    if (options.root) {
      return $el;
    }
  };

}).call(this);
