import 'package:baasbox/baasbox.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'dart:async';

void main() {
  useHtmlConfiguration();

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

    test('Fetch User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future result = aBBUser.login();
      result.then((value) => aBBUser.fetch('test').then((onValue) => print("Fetch User $onValue")));

      expect(result, completes);
    });

    test('Current User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future result = aBBUser.login();
      result.then((value) => aBBUser.current().then((onValue) => print("Current User $onValue")));

      expect(result, completes);
    });


    test('Change Password ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future result = aBBUser.login();
      result.then((value) => aBBUser.changePassword('test').then((onValue) {
        print("Change Password $onValue");

      }));
      aBBUser.changePassword('test');

      expect(result, completes);
    });


    test('Follow User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.follow('Giovanni'));

      expect(result, completes);

    });


    test('Followers User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.followers().then((onValue) => print('Followers ' + aBBUser.followersList.toString())));

      expect(result, completes);

    });

    test('Unfollow', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.unfollow('Giovanni'));

      expect(result, completes);

    });


    test('Fetch Users ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.fetchUsers().then((onValue) => print("Fetch users $onValue")));

      expect(result, completes);

    });


    test('Logout User ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      Future result = loginFuture.then((value) => aBBUser.logout());

      expect(result, completes);

    });

    test('Auto suspended User ', () {
      BaasBoxUser anUser = new BaasBoxUser.withUserName("test");
      anUser.password = 'test';

      Future loginFuture = anUser.login();
      Future result = loginFuture.then((value) => anUser.suspendMe().then((onValue) => print("Auto suspended User $onValue")));


      expect(result, completes);

    });

    test('Admin suspend User ', () {
         BaasBoxUser admin = new BaasBoxUser.withUserName("admin");
         admin.password = 'admin';

         BaasBoxUser suspendedUser = new BaasBoxUser.withUserName("test");

         Future loginFuture = admin.login();
         Future result = loginFuture.then((value) => admin.suspend(suspendedUser).then((onValue) => print("Admin reactivate User $onValue")));

         expect(result, completes);

       });

    test('Admin reactivate User ', () {
      BaasBoxUser admin = new BaasBoxUser.withUserName("admin");
      admin.password = 'admin';

      BaasBoxUser suspendedUser = new BaasBoxUser.withUserName("test");

      Future loginFuture = admin.login();
      Future result = loginFuture.then((value) => admin.reactivate(suspendedUser).then((onValue) => print("Admin reactivate User $onValue")));

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
        }).then((createResponse) => print("Documento creato " + bbDocument.id));

      });

      expect(result, completes);

    });


    test('Delete Document ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then((value) {
        bbDocument.create("testcollection", {
          'text': 'da cancellare'
        }).then((createResponse) => bbDocument.delete('testcollection').then((onValue) => print('Delete Document $onValue')));

      });

      expect(result, completes);

    });


    test('Count Documents ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then((value) {
        bbDocument.count("testcollection").then((onValue) => print("Count $onValue"));

      });
      expect(result, completes);

    });



    test('Update Document field ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then((value) {
        bbDocument.create("testcollection", {
          'text': 'ciao da giovanni'
        }).then((createResponse) {
          bbDocument.updateField('text', bbDocument.id, 'testcollection', {
            'data': 'edited field'
          }).then((onValue) => print("Edit field $onValue"));
        });

      });

      expect(result, completes);

    });

    test('Grant Permissions on Document ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxDocument bbDocument = new BaasBoxDocument();
      Future<Map> result = loginFuture.then((value) {
        bbDocument.create("testcollection", {
          'text': 'ciao da giovanni'
        }).then((createResponse) {
          bbDocument.grantPermissions('all', 'test');
        });

      });

      expect(result, completes);

    });
  });

  group('OO BaasBox Dart SDK Collection ', () {
    BaasBoxContext bbCtxt;

    setUp(() {
      bbCtxt = new BaasBoxContext();

    });


    test('Create Collection ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxCollection bbCollection = new BaasBoxCollection('collectionnew');
      Future<Map> result = loginFuture.then((value) {
        bbCollection.create().then((createResponse) => print("Collection created $createResponse"));

      });

      expect(result, completes);

    });

    test('Delete Collection ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxCollection bbCollection = new BaasBoxCollection('collectionnew');
      Future<Map> result = loginFuture.then((value) {
        bbCollection.delete().then((createResponse) => print("Collection deleted $createResponse"));

      });

      expect(result, completes);

    });

    test('Load Documents ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxCollection bbCollection = new BaasBoxCollection('testcollection');
      Future<Map> result = loginFuture.then((value) {
        bbCollection.loadDocuments().then((onValue) => print("Load Documents $onValue"));

      });


      expect(result, completes);

    });
  });

  group('OO BaasBox Dart SDK Push Notifications ', () {

    test('Enable a Push Notification ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxPushNotification pushNotification = new BaasBoxPushNotification('android', '1010');
      Future<Map> result = loginFuture.then((value) {
        pushNotification.enable().then((response) => print("Push Notification enabled $response"));

      });

      expect(result, completes);

    });


    test('Disable a Push Notification ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxPushNotification pushNotification = new BaasBoxPushNotification('android', '1010');
      Future<Map> result = loginFuture.then((value) {
        pushNotification.disable().then((response) => print("Push Notification disabled $response"));

      });

      expect(result, completes);

    });

    test('Send a Push Notification ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("test");
      aBBUser.password = 'test';
      Future loginFuture = aBBUser.login();
      BaasBoxPushNotification pushNotification = new BaasBoxPushNotification('android', '1010');
      Future<Map> result = loginFuture.then((value) {
        pushNotification.enable().then((enableResponse) {

          pushNotification.send('Giovanni', {
            'message': 'hi from test'
          }).then((response) => print("Push Notification sent $response"));

        });

      });

      expect(result, completes);

    });
  });


  group('OO BaasBox Dart SDK Asset ', () {

    test('Create a JSON Asset ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxAsset aJSONAsset = new BaasBoxAsset('anAsset', {
        'text': 'aaaaaa'
      });
      Future<Map> result = loginFuture.then((value) {
        aJSONAsset.create().then((response) => print("Asset creation $response"));

      });

      expect(result, completes);

    });

    test('Retrieve a JSON Asset ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxAsset aJSONAsset = new BaasBoxAsset('anAsset', {
        'text': 'aaaaaa'
      });
      Future<Map> result = loginFuture.then((value) {
        aJSONAsset.retrieve().then((response) => print("Asset retrieved $response"));

      });

      expect(result, completes);

    });

    test('Delete a JSON Asset ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxAsset aJSONAsset = new BaasBoxAsset('anAsset', {
        'text': 'aaaaaa'
      });
      Future<Map> result = loginFuture.then((value) {
        aJSONAsset.delete().then((response) => print("Asset deleted $response"));

      });

      expect(result, completes);

    });

    test('Fetch JSON Assets ', () {
      BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
      aBBUser.password = 'admin';
      Future loginFuture = aBBUser.login();
      BaasBoxAsset aJSONAsset = new BaasBoxAsset('anAsset', {
        'text': 'aaaaaa'
      });
      Future<Map> result = loginFuture.then((value) {
        aJSONAsset.fetch().then((response) => print("Assets fetched $response"));

      });

      expect(result, completes);

    });


  });
  
  
  group('OO BaasBox Dart SDK API Settings ', () {

     test('Fetch API Settings', () {
       BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
       aBBUser.password = 'admin';
       Future loginFuture = aBBUser.login();
       BaasBoxApiSettings apiSettings = new BaasBoxApiSettings(); 
       Future<Map> result = loginFuture.then((value) {
         apiSettings.fetchCurrentSettings();
       });

       expect(result, completes);

     });
     
     
     test('Fetch API Section Settings', () {
           BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
           aBBUser.password = 'admin';
           Future loginFuture = aBBUser.login();
           BaasBoxApiSettings apiSettings = new BaasBoxApiSettings(); 
           Future<Map> result = loginFuture.then((value) {
             apiSettings.fetchCurrentSettingsSection('Application').then((onValue) => print(onValue));
           });

           expect(result, completes);

         });
     
     test('Update value in API Section Settings', () {
                BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
                aBBUser.password = 'admin';
                Future loginFuture = aBBUser.login();
                BaasBoxApiSettings apiSettings = new BaasBoxApiSettings(); 
                Future<Map> result = loginFuture.then((value) {
                  apiSettings.updateValueInSettings('Application', 'application.name', 'testapp').then((onValue) => print(onValue));
                });

                expect(result, completes);

              });
  });

  

  group('OO BaasBox Dart SDK API Access ', () {

     test('Fetch API Access groups', () {
       BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
       aBBUser.password = 'admin';
       Future loginFuture = aBBUser.login();
       BaasBoxApiAccess apiAccess = new BaasBoxApiAccess(); 
       Future<Map> result = loginFuture.then((value) {
         apiAccess.listGroups().then( (onValue) => print('Groups $onValue'));
       });

       expect(result, completes);

     });
     test('Read API Access group', () {
           BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
           aBBUser.password = 'admin';
           Future loginFuture = aBBUser.login();
           BaasBoxApiAccess apiAccess = new BaasBoxApiAccess(); 
           Future<Map> result = loginFuture.then((value) {
             apiAccess.readGroup('baasbox.assets').then( (onValue) => print('Group $onValue'));
           });

           expect(result, completes);

         });
    
     
     test('Disable API Access group', () {
              BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
              aBBUser.password = 'admin';
              Future loginFuture = aBBUser.login();
              BaasBoxApiAccess apiAccess = new BaasBoxApiAccess(); 
              Future<Map> result = loginFuture.then((value) {
                apiAccess.disableGroup('baasbox.assets').then( (onValue) => print('Disable Group $onValue'));
              });

              expect(result, completes);

            });
     
     test('Enable API Access group', () {
                  BaasBoxUser aBBUser = new BaasBoxUser.withUserName("admin");
                  aBBUser.password = 'admin';
                  Future loginFuture = aBBUser.login();
                  BaasBoxApiAccess apiAccess = new BaasBoxApiAccess(); 
                  Future<Map> result = loginFuture.then((value) {
                    apiAccess.enableGroup('baasbox.assets').then( (onValue) => print('Enable Group $onValue'));
                  });

                  expect(result, completes);

                });
  
  });

}
