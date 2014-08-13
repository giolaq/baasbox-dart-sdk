part of baasbox;


class BaasBoxContext {

  static final String SDK_VERSION = "0.0.2";

  static BaasBoxContext _baasboxcontext;

  BaasBoxConfig _config;
  BaasBoxRequest baasboxRequest;
  
  factory BaasBoxContext() {
    if (_baasboxcontext == null) {
      _baasboxcontext = new BaasBoxContext._internal();
      _baasboxcontext._config = new BaasBoxConfig();
      _baasboxcontext.baasboxRequest = new BaasBoxRequest(_baasboxcontext._config);

    }
    return _baasboxcontext;
  }

  BaasBoxContext._internal();

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
      HttpRequest any = baasboxRequest.any(completer, method, endpoint, body, handler);

    }
    return ftr;

  }


}
