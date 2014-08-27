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
    BaasBoxContext bbCtxt;

    setUp(() {
      bbCtxt = new BaasBoxContext();

    });

    test('Create User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("Giovanni");
      Future result = aBBUser.signup();

      expect(result, completes);

    });

    test('Login User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future result = aBBUser.login();
      result.then((value) => print("Current User " + bbCtxt.getCurrentUser().toString()));

      expect(result, completes);
    });

    test('Logout User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.logout());

      expect(result, completes);

    });

  });
  group('OO BaasBox Dart SDK Document ', () {
    BaasBoxContext bbCtxt;

    setUp(() {
      bbCtxt = new BaasBoxContext();

    });


    test('Create Document ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then((value) {
        bbDocument.create("testcollection", {
          'text': 'ciao da giovanni'
        }).then ( (createResponse) => print("Documento creato $createResponse"));
        
      });

      expect(result, completes);

    });
    

    test('Count Documents ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then( (value) {
        bbDocument.count("testcollection").then( (onValue) => print("Count $onValue"));

      });


      expect(result, completes);

    });
  });

}
