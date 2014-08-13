part of baasbox;


class BaasBoxRequest {


  static final String BASIC_AUTH_HEADER_NAME = "Authorization";
  static final String BB_SESSION_HEADER_NAME = "X-BB-SESSION";
  static final String APPCODE_HEADER_NAME = "X-BAASBOX-APPCODE";
  static final String CONTENT_HEADER = "Content-Type";
  static final String JSON_CONTENT = "application/json";
  static final String FORM_ENCODED_CONTENT = "application/x-www-form-urlencoded;charset=";

  static final String USER_AGENT_HEADER_NAME = "User-Agent";
  static final String USER_AGENT_HEADER = "BaasBox DartSDK/" + BaasBoxContext.SDK_VERSION;

  static final String CONTENT_LENGTH = "Content-Length";

  final BaasBoxConfig _config;
  final String _apiRoot;

  BaasBoxRequest(BaasBoxConfig config)
      : _config = config,
        _apiRoot = _initApiRoot(config);


  static String _initApiRoot(BaasBoxConfig config) {
    StringBuffer api = new StringBuffer();
    api.write(config.useHttps ? "https://" : "http://");
    api.write(config.apiDomain);
    api.write(":");
    api.write(config.httpPort);
    if (config.apiBasepath == null || config.apiBasepath.isEmpty) {
      api.write('/');
    } else if (config.apiBasepath.startsWith("/")) {
      api.write(config.apiBasepath);
    } else {
      api.write('/');
      api.write(config.apiBasepath);
    }

    return api.toString();
  }



  String getEndpointRaw(String endpoint) {
    if (endpoint.startsWith("/")) {
      endpoint = endpoint.substring(1);
    }
    return this._apiRoot + endpoint;
  }


  HttpRequest any(Completer completer, String method, String endpoint, Map body,[handler()]) {
    HttpRequest request;
    switch (method) {
      case 'GET':
        return get(endpoint);
      case 'POST':
        request = post(endpoint, body);
        request.onLoadEnd.listen((e) => completer.complete(handler));
        return request;
      case 'PUT':
        return put(endpoint, body);
      case 'DELETE':
        return delete(endpoint);
      default:
        return null;
    }
    //case 'PATCH':
    //    throw new UnsupportedOperationException("method not supported");
    //default:
    //    throw new IllegalArgumentException("method is not valid");

  }

  HttpRequest get(String endpoint) {
    HttpRequest httpR = new HttpRequest();

    return httpR;
  }

  HttpRequest post(String endpoint, [Map body]) {
    HttpRequest httpR = new HttpRequest();

    httpR
        ..open('POST', endpoint)
        ..setRequestHeader(APPCODE_HEADER_NAME, _config.appCode)
        ..setRequestHeader(CONTENT_HEADER, JSON_CONTENT);

    if (body != null) {
      // convert the JsonObject data back to a string
      String json = JSON.encode(body);

      httpR.send(json);
    } else httpR.send();

    return httpR;
  }

  HttpRequest put(String endpoint, Map body) {
    HttpRequest httpR = new HttpRequest();

    return httpR;
  }

  HttpRequest delete(String endpoint) {
    HttpRequest httpR = new HttpRequest();

    return httpR;
  }


}
