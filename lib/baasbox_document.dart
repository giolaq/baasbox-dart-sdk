part of baasbox;

class BaasBoxDocument {
  Map data;
  String collection;
  String id;
  String author;
  String creation_date;
  String rid;
  double version;
  

  Future create(String collection, Map data) {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("POST", '/document/' + collection , data, true);
    return ftr;
  }
}
