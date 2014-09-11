part of baasbox;


class BaasBoxCollection {

  String name;
  BaasBoxContext _bbCtxt;

  BaasBoxCollection(this.name) {
    this._bbCtxt = new BaasBoxContext();
  }

  Future create() => _bbCtxt.rest("POST", '/admin/collection/$name', true);

  Future delete() => _bbCtxt.rest("DELETE", '/admin/collection/$name', true);

  Future<Map> loadDocuments() => _bbCtxt.rest('GET', '/document/$name', true);

}
