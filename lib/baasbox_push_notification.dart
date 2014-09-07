part of baasbox;

class BaasBoxPushNotification {
  String os;
  String pushToken;
  

  BaasBoxPushNotification(this.os, this.pushToken);
  
  Future<Map> enable() {

    Future ftr;
    

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("PUT", '/push/enable/$os/$pushToken', true);

    return ftr;
  }

  Future<Map> disable() {

      Future ftr;

      BaasBoxContext bbCtxt = new BaasBoxContext();

      ftr = bbCtxt.rest("PUT", '/push/disable/$pushToken', true);

      return ftr;
    }
  
  Future send(String user, Map dataToSend) {

     Future ftr;

     BaasBoxContext bbCtxt = new BaasBoxContext();

     ftr = bbCtxt.rest("POST", '/push/message/$user', true, dataToSend);

     return ftr;
   }

}