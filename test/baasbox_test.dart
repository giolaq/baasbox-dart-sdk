import 'package:baasbox/baasbox.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'dart:async';

void main() {
  useHtmlConfiguration();

  BaasBox bb;

  group('login future', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
    });

    test('login', () {
      var future = bb.login('test', 'test');
      expect(future, completes);
    });
  });

  group('login future right user', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
    });

    test('login ok', () {
      Future<Map> future = bb.login('test', 'test');
        expect(future, completion( containsPair('result', 'ok') ));
        //expect(future, completion( containsPair("name", 'test') ));
      expect(future, completes);

    });
  });
  
  group('login future wrong user', () {
     setUp(() {
       bb = new BaasBox();
       bb.setEndPoint("http://localhost:9000");
       bb.appcode = "1234567890";
     });

     test('login not ok', () {
       Future<Map> future = bb.login('testo', 'testa');
         expect(future, completion( containsPair('result', 'error') ));
         //expect(future, completion( containsPair("name", 'test') ));
       expect(future, completes);

     });
   });
}
