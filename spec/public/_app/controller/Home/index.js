(function() {
  var base,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  if ((base = App.Controller).Home == null) {
    base.Home = {};
  }

  App.Controller.Home.Index = (function(superClass) {
    extend(Index, superClass);

    function Index() {
      return Index.__super__.constructor.apply(this, arguments);
    }

    Index.prototype.init = function() {
      return this.element = $(document.body);
    };

    Index.prototype.bind = function() {};

    return Index;

  })(App.Controller.Base);

}).call(this);
