part of baasbox;


class BaasBoxContext {

  static final String SDK_VERSION = "0.0.6";

  static BaasBoxContext _baasboxcontext;

  BaasBoxConfig _config;
  BaasBoxRequest baasboxRequest;

  Map user;

  factory BaasBoxContext.withConfig(BaasBoxConfig config) {
    if (_baasboxcontext == null) {
      _baasboxcontext = new BaasBoxContext._internal();
      _baasboxcontext._config = config;
      _baasboxcontext.baasboxRequest = new BaasBoxRequest(_baasboxcontext._config);

    }
    return _baasboxcontext;
  }

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
  Future<Map> rest(String method, String endpoint, bool authenticate, [Map body] ) {
    Completer completer = new Completer();
    Future ftr = completer.future;

    if (endpoint == null) {
      print("endpoint cannot be null");
    } else {
      HttpRequest any = baasboxRequest.any(method, endpoint, authenticate, body );
      any.onLoadEnd.listen((event) => completer.complete(handleResponse(any)));

    }
    return ftr;

  }

  Future<Map> restString(String method, String endpoint, bool authenticate, [String body] ) {
    Completer completer = new Completer();
    Future ftr = completer.future;

    if (endpoint == null) {
      print("endpoint cannot be null");
    } else {
      HttpRequest any = baasboxRequest.anyString(method, endpoint, authenticate, body );
      any.onLoadEnd.listen((event) => completer.complete(handleResponse(any)));

    }
    return ftr;

  }


  void setCurrentUser(var user) {
    this.user = user;
  }

  Map getCurrentUser() {
    return this.user;
  }

  void setCurrentDomain(String currentDomain) {
    _config.apiDomain = currentDomain;
  }

  Map handleResponse(HttpRequest request) {
    Map parsedBody = new Map();
    if (request.status == 200 || request.status == 201) {
      parsedBody = JSON.decode(request.response);
      //List roles = [];
      //parsedBody["data"]["user"]["roles"].forEach((element) => roles.add(element['name']));
     /* setCurrentUser({
        "username": parsedBody["data"]["user"]["name"],
        "token": parsedBody["data"]['X-BB-SESSION'],
        // "roles": roles,
        "visibleByAnonymousUsers": parsedBody["data"]["visibleByAnonymousUsers"],
        "visibleByTheUser": parsedBody["data"]["visibleByTheUser"],
        "visibleByFriends": parsedBody["data"]["visibleByFriends"],
        "visibleByRegisteredUsers": parsedBody["data"]["visibleByRegisteredUsers"],
      });*/
    } else {
      print('Error ' + request.response);
    }



    return parsedBody;
  }

}
