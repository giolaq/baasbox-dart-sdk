part of baasbox;


class BaasBoxUser {


  String _username;
  String _password;
  String _authToken;
  String _signupDate;
  String _status;
  List followersList;

  HashSet<String> roles;


  BaasBoxUser(this._username, this._password, this._signupDate, this._status, this._authToken);


  BaasBoxUser.withUserName(this._username);

  set password(String password) => _password = password;

  get username => _username;

  Future signup() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    var postData = {
      'username': this._username,
      'password': this._password
    };

    ftr = bbCtxt.rest("POST", '/user', false, postData);
    return ftr;
  }


  Future login() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    Map requestBody = {
      'username': this._username,
      'password': this._password,
      'appcode': bbCtxt._config.mAppCode
    };

    ftr = bbCtxt.rest("POSTFORM", '/login', false, requestBody).then((response) => bbCtxt.setCurrentUser({
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



  Future logout() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();



    ftr = bbCtxt.rest("POST", '/logout', true);

    return ftr;

  }


  Future fetch(String user) {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();



    ftr = bbCtxt.rest("GET", '/user/$user', true);

    return ftr;

  }

  Future current() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/me', true);

    return ftr;

  }


  Future changePassword(String newPassword) {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    var postData = {
      'old': this._password,
      'new': newPassword
    };

    ftr = bbCtxt.rest("PUT", '/me/password', true, postData);
    return ftr;
  }


  Future follow(String userToFollow) {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("POST", '/follow/$userToFollow', true);
    return ftr;
  }

  Future unfollow(String userToFollow) {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("DELETE", '/follow/$userToFollow', true);
    return ftr;
  }

  Future followers() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/followers/$_username', true).then((onResponse) {
      print(onResponse);
      followersList = onResponse['data'];
    });
    return ftr;
  }


  Future<Map> fetchUsers() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/users', true);
    return ftr;
  }

  Future<Map> suspendMe() {


    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("PUT", '/me/suspend', true);
    return ftr;

  }
  
  Future<Map> suspend(BaasBoxUser anUserToSuspend) {


      Future ftr;

      BaasBoxContext bbCtxt = new BaasBoxContext();

      ftr = bbCtxt.rest("PUT", '/admin/user/activate/' + anUserToSuspend.username , true);
      return ftr;

    }
  
  
  Future<Map> reactivate(BaasBoxUser aSuspendedUser) {


     Future ftr;

     BaasBoxContext bbCtxt = new BaasBoxContext();

     ftr = bbCtxt.rest("PUT", '/admin/user/activate/' + aSuspendedUser.username , true);
     return ftr;

   }

}
