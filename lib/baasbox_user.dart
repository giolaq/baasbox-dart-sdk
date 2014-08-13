part of baasbox;


class BaasBoxUser {


  String _username;
  String _password;
  String _authToken;
  String _signupDate;
  String _status;

  HashSet<String> roles;


  BaasBoxUser(this._username, this._password, this._signupDate, this._status, this._authToken);


  BaasBoxUser.withUserName(this._username);

  set password(String password) => _password = password;



  Future<Map> signup() {
    var completer = new Completer();
    Future ftr = completer.future;

    BaasBoxContext bbCtxt = new BaasBoxContext(null);
    var url = bbCtxt.endpoint + '/user';

    var postData = {
      'username': this._username,
      'password': this._password
    };

    //acl.forEach((key, value) => postData['key'] = value);

    // convert the JsonObject data back to a string
    String json = JSON.encode(postData);

    HttpRequest request = new HttpRequest();
    request
        ..open('POST', url)
        ..setRequestHeader('X-BAASBOX-APPCODE', bbCtxt.appcode)
        ..setRequestHeader('Content-type', 'application/json')
        ..onLoadEnd.listen((e) => completer.complete(handleLoginResponse(request)))
        ..send(json);

    return ftr;
  }

  String encodeMap(Map data) {
    return data.keys.map((k) {
      return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
    }).join('&');
  }

  Map handleLoginResponse(HttpRequest request) {
    Map parsedBody = new Map();
    if (request.status == 201) {
      parsedBody = JSON.decode(request.response);
      List roles = [];
      parsedBody["data"]["user"]["roles"].forEach((element) => roles.add(element['name']));
      /* setCurrentUser({
            "username": parsedBody["data"]["user"]["name"],
            "token": parsedBody["data"]['X-BB-SESSION'],
            "roles": roles,
            "visibleByAnonymousUsers": parsedBody["data"]["visibleByAnonymousUsers"],
            "visibleByTheUser": parsedBody["data"]["visibleByTheUser"],
            "visibleByFriends": parsedBody["data"]["visibleByFriends"],
            "visibleByRegisteredUsers": parsedBody["data"]["visibleByRegisteredUsers"],
          });*/
    } else {
      print('Signup error ' + request.response);
    }

    return parsedBody;
  }

  Future signupN() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext(null);
    var url = bbCtxt.endpoint + '/user';

    var postData = {
      'username': this._username,
      'password': this._password
    };

    ftr = bbCtxt.rest("POST", '/user', postData, false);
    return ftr;
  }
}
