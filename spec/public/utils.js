(function() {
  if (this.App == null) {
    this.App = {};
  }


  /*
   * Class for Util functions
   */

  App.Util = (function() {
    function Util() {}

    Util.parse_datetime = function(str) {
      var d;
      if (str == null) {
        return null;
      }
      if (d = str.match(/^(\d{4})-(\d{2})-(\d{2})/)) {
        return new Date(d[1] + "-" + d[2] + "-" + d[3]);
      }
    };

    return Util;

  })();

}).call(this);
