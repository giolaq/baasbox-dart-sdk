part of baasbox;


class BaasBoxContext {

  static final String SDK_VERSION = "0.0.2";

  static BaasBoxContext _baasboxcontext;

  final BaasBoxConfig config;
  BaasBoxRequest baasboxRequest;

  factory BaasBoxContext(BaasBoxConfig config) {
    if (_baasboxcontext == null) {
      _baasboxcontext = new BaasBoxContext._internal(config);
      _baasboxcontext.baasboxRequest = new BaasBoxRequest(config);

    }
    return _baasboxcontext;
  }

  BaasBoxContext._internal(this.config);

  get endpoint => 'http://' + config.apiDomain + ':' + config.httpPort.toString();

  get appcode => config.appCode;


  /**
     * Asynchronously sends a raw rest request to the server that is specified by
     * the parameters passed in.
     *
     * @param method       the method to use
     * @param endpoint     the resource
     * @param body         an optional Map object
     * @param authenticate true if the client should try to refresh authentication automatically
     * @param handler      a callback to handle the json response
     */
  Future rest(String method, String endpoint, Map body, bool authenticate, [handler()]) {
    Completer completer = new Completer();
       Future ftr = completer.future;

    if (endpoint == null) {
      print("endpoint cannot be null");
    } else {
      endpoint = baasboxRequest.getEndpointRaw(endpoint);
      HttpRequest any = baasboxRequest.any(completer, method, endpoint, body, handler);

    }
    return ftr;

  }


}
