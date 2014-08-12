
part of baasbox;

typedef BaasBoxRequest BaasBoxRequestFactory();

BaasBoxRequest _newBaasBoxRequest() => new BaasBoxRequest();


class BaasBoxContext {
  
  static BaasBoxContext _baasboxcontext;
  
  final BaasBoxConfig config;
  BaasBoxRequestFactory baasboxRequestFactory;

  factory BaasBoxContext(BaasBoxConfig config) {
    if  ( _baasboxcontext == null ) {
      _baasboxcontext = new BaasBoxContext._internal(config);
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
     Future rest(int method, String endpoint, Map body, bool authenticate, [handler()]) {
        return rest(method, endpoint, body, false, handler);
    }


}