(function() {
  if (App.Service == null) {
    App.Service = {};
  }

  App.Service.Address = (function() {
    function Address() {}

    Address.get = function(cep) {
      return $.ajax({
        url: "http://api.postmon.com.br/v1/cep/" + cep,
        dataType: 'json'
      });
    };

    return Address;

  })();

}).call(this);
