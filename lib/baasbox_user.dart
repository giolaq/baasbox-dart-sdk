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


  Future signup() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();
    
    var postData = {
      'username': this._username,
      'password': this._password
    };

    ftr = bbCtxt.rest("POST", '/user', postData, false);
    return ftr;
  }
  
  
  Future login() {
      Future ftr;

      BaasBoxContext bbCtxt = new BaasBoxContext();
     
      Map requestBody = {
        'username':  this._username,
        'password': this._password,
        'appcode': bbCtxt._config.mAppCode
      };
           
      ftr = bbCtxt.rest("POSTFORM", '/login', requestBody, false);


      return ftr;

    }
  

  
  Future logout() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();
    
   

    ftr = bbCtxt.rest("POST", '/logout', null, false);
    
    return ftr;

  }

}
