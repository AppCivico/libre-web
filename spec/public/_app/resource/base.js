(function() {
  App.Resource = App.Resource || {};

  App.Resource.Base = (function() {
    Base.base_api = "" + App.config.API_BASE;

    function Base(options1) {
      this.options = options1 != null ? options1 : {};
      this.id = this.options.id || 0;
    }

    Base.get = function(options) {
      var req_params;
      if (options == null) {
        options = {};
      }
      req_params = this._get_request_params('GET', options);
      return $.ajax(req_params);
    };

    Base.post = function(options) {
      var req_params;
      if (options == null) {
        options = {};
      }
      req_params = this._get_request_params('POST', options);
      return $.ajax(req_params);
    };

    Base.put = function(options) {
      var req_params;
      if (options == null) {
        options = {};
      }
      req_params = this._get_request_params('PUT', options);
      return $.ajax(req_params);
    };

    Base.remove = function(options) {
      var req_params;
      if (options == null) {
        options = {};
      }
      req_params = this._get_request_params('DELETE', options);
      return $.ajax(req_params);
    };

    Base.request = function(options) {
      var method, req_params;
      if (options == null) {
        options = {};
      }
      method = options.method || 'GET';
      req_params = this._get_request_params(method, options);
      return $.ajax(req_params);
    };

    Base.load = function(id, options) {
      if (id == null) {
        id = 0;
      }
      if (options == null) {
        options = {};
      }
      return this.get({
        endpoint: options.endpoint || (this.base_api + "/" + id),
        params: options.params || {}
      });
    };

    Base.all = function(options) {
      if (options == null) {
        options = {};
      }
      return this.get({
        endpoint: options.endpoint || ("" + this.base_api),
        params: options.params || {}
      });
    };

    Base._set_api_key = function(params) {
      if (params == null) {
        params = {};
      }
      params.api_key = session() && session().get('user') ? session().get('user').apikey : null;
      return params;
    };

    Base._get_request_params = function(method, options) {
      var api_key, endpoint, headers_params, req_params;
      if (method == null) {
        method = 'GET';
      }
      if (options == null) {
        options = {};
      }
      options.params = this._set_api_key(options.params);
      headers_params = options.headers || {};
      endpoint = "" + this.base_api + (options.endpoint || '');
      if (session() && session().get('user')) {
        api_key = session().get('user').apikey;
        if (endpoint.indexOf('api_key=') === -1) {
          endpoint = endpoint + "?api_key=" + api_key;
        }
      }
      req_params = {
        cache: false,
        method: method,
        crossDomain: App.config.CORS || true,
        url: endpoint,
        data: options.params || {},
        dataType: 'json'
      };
      if (headers_params) {
        req_params['headers'] = headers_params;
      }
      if (options.content_type != null) {
        req_params['contentType'] = options.content_type;
      }
      if (options.process_data != null) {
        req_params['processData'] = options.process_data;
      }
      if (App.config.DEBUG) {
        console.debug(req_params);
      }
      return req_params;
    };

    return Base;

  })();

}).call(this);
