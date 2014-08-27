part of baasbox;


class BaasBoxContext {

  static final String SDK_VERSION = "0.0.2";

  static BaasBoxContext _baasboxcontext;

  BaasBoxConfig _config;
  BaasBoxRequest baasboxRequest;

  Map user;

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
      any.onLoadEnd.listen((event) => completer.complete(handleLoginResponse(any)));

    }
    return ftr;

  }


  void setCurrentUser(var user) {
    this.user = user;
  }

  Map getCurrentUser() {
    return this.user;
  }

  Map handleLoginResponse(HttpRequest request) {
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
      print('Login error ' + request.response);
    }



    return parsedBody;
  }

}
