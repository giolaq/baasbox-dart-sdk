library baasbox;

import 'dart:core';
import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'package:http/http.dart' as http;

class BaasBox {

  var instance;
  var user;
  var endPoint;
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
  
  Cookie cookie;

  void setEndPoint(var endPointURL) {
    String regExpString = r'/(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/';
    RegExp regExp = new RegExp(regExpString);
    if (regExp.firstMatch(endPointURL) != null) {
      endPoint = endPointURL;
    } else {
      // window.alert('$endPointURL is not a valid URL');
    }

  }

  void login(String usr, String pwd) {
    var url = 'http://localhost:9000/login';
    http.post(url, body: {
      'username': usr,
      'password': pwd,
      'appcode': appcode
    }).then((response) {
      Map parsedBody = JSON.decode(response.body);
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
      print(getCurrentUser());

    });

  }

  void setCurrentUser(var user) {
    print( Uri.encodeFull(JSON.encode(user)));
    cookie = new Cookie(COOKIE_KEY,  Uri.encodeComponent(JSON.encode(user)));
  }
  
  Map getCurrentUser() {
   return JSON.decode( Uri.decodeComponent(cookie.value) );
  }

  

}
