(function() {
  Turbolinks.start();

  document.addEventListener("turbolinks:load", function() {
    var e;
    try {
      return Application.init();
    } catch (error) {
      e = error;
      return console.error(e.message);
    }
  });

}).call(this);
