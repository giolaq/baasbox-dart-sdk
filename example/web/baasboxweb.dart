import 'dart:html';
import 'package:baasbox/baasbox.dart';

BaasBox bb;

void main() {

  bb = new BaasBox();
  bb.setEndPoint("http://localhost:9000");
  bb.appcode = "1234567890";
  querySelector("#login")
      ..text = "Login"
      ..onClick.listen(login);

  querySelector("#logout")
      ..text = "Logout"
      ..onClick.listen(logout);
  
  querySelector("#signup")
        ..text = "Signup"
        ..onClick.listen(signup);
}

void login(MouseEvent event) {

  bb.login('test', 'test').then((user) => print('Login ok of $user')).catchError((e) => print('Error $e)'));

}

void logout(MouseEvent event) {

  bb.logout();
}

void signup(MouseEvent event) {

  bb.signup('giovanni', 'test', {'visibleByTheUser' : true}).then((user) => print('Signup ok for $user')).catchError((e) => print('Error $e)'));

}
