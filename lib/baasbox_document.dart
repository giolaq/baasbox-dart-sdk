part of baasbox;

class BaasBoxDocument {
  Map data;
  String collection;
  String id;
  String author;
  String creation_date;
  String rid;
  double version;

  BaasBoxContext _bbCtxt = new BaasBoxContext();

  BaasBoxDocument() {
    this._bbCtxt = new BaasBoxContext();
  }

  Future create(String collection, Map dataInDocument) {

    Future ftr;
    ftr = _bbCtxt.rest("POST", '/document/' + collection, true, dataInDocument);

    ftr.then((documentCreated) {
      this.data = documentCreated['data'];
      this.id = data['id'];
      this.collection = collection;
    });

    return ftr;
  }

  Future<Map> retrieve(String documentId, String collection) => _bbCtxt.rest("GET", '/document/' + collection + '/' + documentId, true);

  Future modify(String documentId, String collection, Map data) => _bbCtxt.rest("PUT", '/document/' + collection + '/' + documentId, true, data);

  Future delete(String collection) => _bbCtxt.rest("DELETE", '/document/' + collection + '/' + id, true);

  Future<Map> count(String collection) => _bbCtxt.rest("GET", '/document/' + collection + '/count', true);

  Future<Map> updateField(String fieldName, String documentId, String collection, Map dataToEdit) => _bbCtxt.rest("PUT", '/document/$collection/$documentId/.$fieldName', true, dataToEdit);

  Future grantPermissions(String action, String username) => _bbCtxt.rest("PUT", '/document/$collection/$id/$action/user/$username', true);


}
