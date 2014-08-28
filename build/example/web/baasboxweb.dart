import 'dart:html';
import '../../lib/baasbox.dart';


void main() {

  BaasBoxContext bbCtxt;

  querySelector("#login")
      ..text = "Login"
      ..onClick.listen(login);

  querySelector("#logout")
      ..text = "Logout"
      ..onClick.listen(logout);

  querySelector("#signup")
      ..text = "Signup"
      ..onClick.listen(signup);

  querySelector("#currentuser")
      ..text = "Current User"
      ..onClick.listen(fetchCurrentUser);
}

void login(MouseEvent event) {

  BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Giovanni");
  aBBUser.password = 'test';
  aBBUser.login().then((user) => print('Login ok for $user')).catchError((e) => print('Error $e)'));

}

void logout(MouseEvent event) {

  BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Giovanni");
  aBBUser.logout().then((user) => print('Logout ok for $user')).catchError((e) => print('Error $e)'));
}

void signup(MouseEvent event) {
  
  BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Giovanni");
  aBBUser.signup().then((user) => print('Signup ok for $user')).catchError((e) => print('Error $e)'));

}

void fetchCurrentUser(MouseEvent event) {

  BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Giovanni");
  aBBUser.current().then((user) => print('Current user info ok for $user')).catchError((e) => print('Error $e)'));
}
