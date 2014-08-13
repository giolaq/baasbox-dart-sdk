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
    api.write(config.mUseHttps ? "https://" : "http://");
    api.write(config.mApiDomain);
    api.write(":");
    api.write(config.mHttpPort);
    if (config.mApiBasepath == null || config.mApiBasepath.isEmpty) {
      api.write('/');
    } else if (config.mApiBasepath.startsWith("/")) {
      api.write(config.mApiBasepath);
    } else {
      api.write('/');
      api.write(config.mApiBasepath);
    }

    return api.toString();
  }



  String getEndpointRaw(String endpoint) {

    if (endpoint.startsWith("/")) {
      endpoint = endpoint.substring(1);
    }
    return this._apiRoot + endpoint;
  }


  HttpRequest any(Completer completer, String method, String endpointApi, Map body,[handler()]) {
    String endpoint = getEndpointRaw(endpointApi);
    print(endpoint);
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
        ..setRequestHeader(APPCODE_HEADER_NAME, _config.mAppCode)
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
