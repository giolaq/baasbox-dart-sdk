part of baasbox;


class BaasBoxUser {


  String _username;
  String _password;
  String _authToken;
  String _signupDate;
  String _status;
  List followersList;

  HashSet<String> roles;

  BaasBoxContext _bbCtxt;

  BaasBoxUser(this._username, this._password, this._signupDate, this._status, this._authToken) {
    _bbCtxt = new BaasBoxContext();
  }

  BaasBoxUser.withUserName(this._username) {
    _bbCtxt = new BaasBoxContext();
  }

  set password(String password) => _password = password;

  get username => _username;

  Future signup() => _bbCtxt.rest("POST", '/user', false, { 'username': this._username,'password': this._password });
    
  Future login() {
    Future ftr;

    Map requestBody = {
      'username': this._username,
      'password': this._password,
      'appcode': _bbCtxt._config.mAppCode
    };

    ftr = _bbCtxt.rest("POSTFORM", '/login', false, requestBody).then((response) => _bbCtxt.setCurrentUser({
      "username": response["data"]["user"]["name"],
      "token": response["data"]['X-BB-SESSION'],
      // "roles": roles,
      "visibleByAnonymousUsers": response["data"]["visibleByAnonymousUsers"],
      "visibleByTheUser": response["data"]["visibleByTheUser"],
      "visibleByFriends": response["data"]["visibleByFriends"],
      "visibleByRegisteredUsers": response["data"]["visibleByRegisteredUsers"],
    }));
    return ftr;

  }

  Future logout() => _bbCtxt.rest("POST", '/logout', true);

  Future fetch(String user) => _bbCtxt.rest("GET", '/user/$user', true);

  Future current() => _bbCtxt.rest("GET", '/me', true);

  Future changePassword(String newPassword) => _bbCtxt.rest("PUT", '/me/password', true, {'old': this._password,'new': newPassword });
  
  Future follow(String userToFollow) => _bbCtxt.rest("POST", '/follow/$userToFollow', true);

  Future unfollow(String userToFollow) => _bbCtxt.rest("DELETE", '/follow/$userToFollow', true);

  Future followers() => _bbCtxt.rest("GET", '/followers/$_username', true).then((onResponse) {followersList = onResponse['data'];});

  Future<Map> fetchUsers() => _bbCtxt.rest("GET", '/users', true);

  Future<Map> suspendMe() => _bbCtxt.rest("PUT", '/me/suspend', true);

  Future<Map> suspend(BaasBoxUser anUserToSuspend) => _bbCtxt.rest("PUT", '/admin/user/activate/' + anUserToSuspend.username, true);

  Future<Map> reactivate(BaasBoxUser aSuspendedUser) => _bbCtxt.rest("PUT", '/admin/user/activate/' + aSuspendedUser.username, true);

}
