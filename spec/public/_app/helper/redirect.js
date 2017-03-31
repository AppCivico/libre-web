(function() {
  var e;

  try {
    this.redirect_to = function(url) {
      return document.location = url;
    };
  } catch (error) {
    e = error;
    console.error(e.message);
  }

}).call(this);
