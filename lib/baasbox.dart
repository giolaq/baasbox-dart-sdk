library baasbox;

import 'dart:core';
import 'dart:convert';
import 'dart:async';
import 'dart:html';


class BaasBox {

  var instance;
  var user;
  String endPoint;
  var COOKIE_KEY = "baasbox-cookie";

  var appcode = "";
  var pagelength = 50;
  var timeout = 20000;
  var version = "0.8.2";
  // permission constants
  var READ_PERMISSION = "read";
  var DELETE_PERMISSION = "delete";
  var UPDATE_PERMISSION = "update";
  var ALL_PERMISSION = "all";

  // role constants, by default in the BaasBox back end
  var ANONYMOUS_ROLE = "anonymous";
  var REGISTERED_ROLE = "registered";
  var ADMINISTRATOR_ROLE = "administrator";

  BaasBox() {
    this.endPoint = 'http://localhost:9000';
  }

  void setEndPoint(var endPointURL) {
    String regExpString = r"(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?";
    RegExp regExp = new RegExp(regExpString);
    if (regExp.allMatches(endPointURL).isNotEmpty) {
      endPoint = endPointURL;
    } else {
      window.alert('$endPointURL is not a valid URL');
    }

  }

  Future login(String usr, String pwd) {
    var completer = new Completer();
    Future ftr = completer.future;

    var url = this.endPoint + '/login';
    Map requestBody = {
      'username': usr,
      'password': pwd,
      'appcode': appcode
    };
    HttpRequest request = new HttpRequest();
    request
        ..open('POST', url)
        ..setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
        ..onLoadEnd.listen((e) => handleLoginResponse(request))
        ..send(encodeMap(requestBody));

    return ftr;

  }

  void handleLoginResponse(HttpRequest request) {
    if (request.status == 200 || request.status == 201) {
      Map parsedBody = JSON.decode(request.response);
      List roles = [];
      parsedBody["data"]["user"]["roles"].forEach((element) => roles.add(element['name']));
      setCurrentUser({
        "username": parsedBody["data"]["user"]["name"],
        "token": parsedBody["data"]['X-BB-SESSION'],
        "roles": roles,
        "visibleByAnonymousUsers": parsedBody["data"]["visibleByAnonymousUsers"],
        "visibleByTheUser": parsedBody["data"]["visibleByTheUser"],
        "visibleByFriends": parsedBody["data"]["visibleByFriends"],
        "visibleByRegisteredUsers": parsedBody["data"]["visibleByRegisteredUsers"],
      });
    } else {
      print('Login error ' + request.response);
    }


  }

  void logout() {
    var url = this.endPoint + '/logout';

    Map user = getCurrentUser();
    if (user == null) {
      print("already logged out");
      //return deferred.reject({"data" : "ok", "message" : "User already logged out"})
    } else {
      HttpRequest request = new HttpRequest();
      request
          ..open('POST', url)
          ..setRequestHeader('X-BB-SESSION', user['token'])
          ..setRequestHeader('X-BAASBOX-APPCODE', appcode)
          ..setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
          ..onLoadEnd.listen((e) => handleLogoutResponse(request))
          ..send();
    }
  }

  void handleLogoutResponse(HttpRequest request) {
    if (request.status == 200) {
      Map parsedBody = JSON.decode(request.response);
      print('Logout Ok');
      setCurrentUser(null);
    } else {
      print('Logout error ' + request.response);
    }


  }

  void setCurrentUser(var user) {
    this.user = user;
  }

  Map getCurrentUser() {
    return this.user;
  }

  Future signup(var user, var pwd, Map acl) {
    var completer = new Completer();
    Future ftr = completer.future;

    var url = 'http://localhost:9000/user';

    var postData = {
      'username': user,
      'password': pwd
    };

    acl.forEach((key, value) => postData['key'] = value);

    // later...
    // convert the JsonObject data back to a string
    String json = JSON.encode(postData);

    HttpRequest request = new HttpRequest();
    request
        ..open('POST', url)
        ..setRequestHeader('X-BAASBOX-APPCODE', appcode)
        ..setRequestHeader('Content-type', 'application/json')
        ..onLoadEnd.listen((e) => handleLoginResponse(request))
        ..send(json);

    return ftr;
  }

  String encodeMap(Map data) {
    return data.keys.map((k) {
      return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
    }).join('&');
  }


  Future fetchCurrentUser() {
    var completer = new Completer();
    Future ftr = completer.future;

    var url = this.endPoint + '/me';

    if (user != null) {
      HttpRequest request = new HttpRequest();
      request
          ..open('GET', url)
          ..setRequestHeader('X-BB-SESSION', user['token'])
          ..setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
          ..onLoadEnd.listen((e) => handleUserResponse(request))
          ..send();

    }

    return ftr;

  }

  void handleUserResponse(HttpRequest request) {
    if (request.status == 200) {
      Map parsedBody = JSON.decode(request.response);
      List roles = [];
      parsedBody["data"]["user"]["roles"].forEach((element) => roles.add(element['name']));
      print(parsedBody["data"]["user"]["name"]);
      print(parsedBody["data"]["user"]["status"]);

    } else {
      print('Login error ' + request.response);
    }


  }
}
