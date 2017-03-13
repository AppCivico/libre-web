# namespace
App.Resource = App.Resource || {}

# Resource Base class
class App.Resource.Base
  # attributes
  @base_api = "#{App.config.API_BASE}"

  constructor: (@options={}) ->
    @id = @options.id || 0

  # getting data or a list
  @get: (options = {}) ->
    req_params = @_get_request_params 'GET', options
    $.ajax req_params


  # create data
  @post: (options = {}) ->
    req_params = @_get_request_params 'POST', options
    $.ajax req_params


  # update data
  @put: (options = {}) ->
    req_params = @_get_request_params 'PUT', options
    $.ajax req_params


  # delete data
  @remove: (options = {}) ->
    req_params = @_get_request_params 'DELETE', options
    $.ajax req_params


  # request data
  @request: (options = {}) ->
    method = options.method || 'GET'
    req_params = @_get_request_params method, options
    $.ajax req_params


  # load model entity
  @load: (id = 0, options = {}) ->
    @get {
      endpoint: options.endpoint || "#{@base_api}/#{id}"
      params: options.params || {}
    }


  # load list of model entity
  @all: (options = {}) ->
    @get {
      endpoint: options.endpoint || "#{@base_api}"
      params: options.params || {}
    }


  # private methods
  @_set_api_key: (params = {}) ->
    params.api_key = if session() and session().get('user') then session().get('user').apikey else null
    params


  # default and common options
  @_get_request_params: (method='GET', options={}) ->
    # setting api token if exists
    options.params = @_set_api_key(options.params)

    # api-key for header
    headers_params = options.headers || {}

    # endpoint
    endpoint = "#{@base_api}#{(options.endpoint || '')}"

    # getting api_key
    if session() and session().get('user')
      api_key = session().get('user').apikey
      if endpoint.indexOf('api_key=') is -1
        endpoint = "#{endpoint}?api_key=#{api_key}"

    # generating ajax config
    req_params =
      cache: false
      method: method
      crossDomain: App.config.CORS || true
      url: endpoint
      data: options.params || {}
      dataType: 'json'

    req_params['headers'] = headers_params if headers_params

    # custom ajax options
    req_params['contentType'] = options.content_type if options.content_type?
    req_params['processData'] = options.process_data if options.process_data?

    console.debug(req_params) if App.config.DEBUG
    req_params

