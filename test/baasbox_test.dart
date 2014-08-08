import 'package:baasbox/baasbox.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

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
      expect(future, completion(true));
    });
  });

  
  

  group('login future', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
      return bb.login('test', 'test').then((_) => print(bb.user['username']));
                
    });

    test('login ok', () {
      expect(bb.user['username'], equals('test') );
    });
  });
}
