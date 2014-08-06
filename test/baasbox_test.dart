import 'package:baasbox/baasbox.dart';


void main() {
  BaasBox bb = new BaasBox();
  bb.setEndPoint("http://localhost:9000");
  bb.appcode = "1234567890";
  
  bb.login('test', 'test');
  
}