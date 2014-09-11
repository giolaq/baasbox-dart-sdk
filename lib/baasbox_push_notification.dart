part of baasbox;

class BaasBoxPushNotification {
  String os;
  String pushToken;
  
  BaasBoxContext _bbCtxt;

  BaasBoxPushNotification(this.os, this.pushToken) {
   this._bbCtxt = new BaasBoxContext();
  }
 
  Future<Map> enable() => _bbCtxt.rest("PUT", '/push/enable/$os/$pushToken', true);

  Future<Map> disable() => _bbCtxt.rest("PUT", '/push/disable/$pushToken', true);

  Future send(String user, Map dataToSend)  => _bbCtxt.rest("POST", '/push/message/$user', true, dataToSend);
}