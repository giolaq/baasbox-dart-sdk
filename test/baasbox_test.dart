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
      expect(future, completion(containsPair('result', 'ok')));
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
      //expect(future, completion( containsPair('result', 'error') ));
      //expect(future, completion( containsPair("name", 'test') ));
      expect(future, completes);

    });
  });


  group('fetchCurrentUser ', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
    });

    test('fetchCurrentUser ok', () {

      Future<Map> futureFetchUser = bb.login('test', 'test').then((value) => bb.fetchCurrentUser());
      expect(futureFetchUser, completes);

    });
  });


  group('Collections ', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
    });

    test('Create Collection ', () {

      Future<Map> futureFetchUser = bb.login('admin', 'admin').then((value) => bb.createCollection("mynewcollection"));
      expect(futureFetchUser, completes);

    });
  });


  group('Document ', () {
    setUp(() {
      bb = new BaasBox();
      bb.setEndPoint("http://localhost:9000");
      bb.appcode = "1234567890";
    });

    test('Create Document ok', () {
      Map document = {
        'title': 'testdocument',
        'idx': 4342352,
        'sometext': 'Lorem ipsum'
      };

      Future<Map> futureFetchUser = bb.login('test', 'test').then((value) => bb.createDocument("testcollection", document));
      expect(futureFetchUser, completes);

    });


    test('Fetch Document ok', () {
      String collection = 'testcollection';
      Map document = {
        'title': 'testdocument2',
        'idx': 4342352,
        'sometext': 'Lorem ipsum 2'
      };

      Future<Map> futureCreateDocument = bb.login('test', 'test').then((value) => bb.createDocument(collection, document).then((value) => bb.fetchDocument(collection, value['data']['id'])));

    });

    test('Update Document ok', () {
      String collection = 'testcollection';
      Map document = {
        'title': 'testdocument3',
        'idx': 4342352,
        'sometext': 'Lorem ipsum 2'
      };

      Map newDocument = {
        'title': 'testdocument3',
        'idx': 5556666,
        'sometext': 'Lorem  2'
      };

      Future<Map> futureCreateDocument = bb.login('test', 'test').then((value) => bb.createDocument(collection, document).then((value) => bb.updateDocument(collection, value['data']['id'], newDocument)));

    });

    test('Delete Document ok', () {
      String collection = 'testcollection';
      Map document = {
        'title': 'testdocumentToDelete',
        'idx': 4342352,
        'sometext': 'Lorem ipsum 2'
      };

      Future<Map> futureCreateDocument = bb.login('test', 'test').then((value) => bb.createDocument(collection, document).then((value) => bb.deleteDocument(collection, value['data']['id'])));

    });

    test('Counts Documents ok', () {
      String collection = 'testcollection';


      Future<Map> futureCreateDocument = bb.login('test', 'test').then((value) => bb.countDocuments(collection));

    });


  });


  group('OO BaasBox Dart SDK User ', () {
    BaasBoxConfig bbConfig;
    BaasBoxContext bbCtxt;
    String apiBasepath = "/";
    String apiDomain = "127.0.0.1";
    String appCode = "1234567890";
    String authenticationType = "SESSION_TOKEN";
    String httpCharset = "UTF-8";
    int httpConnectionTimeout = 6000;
    int httpSocketTimeout = 10000;
    int httpPort = 9000;
    int keystoreRes = 0;
    String mKeyStorePass = null;
    bool sessionTokenExpires = false;
    List<String> senderIds;
    bool useHttps = false;
    String password = null;

    setUp(() {
      bbConfig = new BaasBoxConfig(apiBasepath, apiDomain, appCode, authenticationType, httpCharset, 
          httpConnectionTimeout, httpPort, httpSocketTimeout, keystoreRes,
          password, senderIds, sessionTokenExpires, useHttps);
      bbCtxt = new BaasBoxContext(bbConfig);

    });

    test('Create User ', () {
        BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Marco");
        Future result = aBBUser.signupN();
        expect(result, completes);

    });
  });

}
