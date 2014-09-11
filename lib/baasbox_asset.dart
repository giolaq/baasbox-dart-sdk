part of baasbox;

class BaasBoxAsset {
  String name;
  Map meta;
  String file;
  Map data;
  String id;

  BaasBoxContext _bbCtxt;

  BaasBoxAsset(this.name, this.meta) {
    this._bbCtxt = new BaasBoxContext();
  }

  Future create() {

    Future ftr;
    Map dataToSend = {
      'name': this.name,
      'meta': JSON.encode(this.meta),
    };

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("POSTFORM", '/admin/asset', true, dataToSend);

    ftr.then((documentCreated) {
      this.data = documentCreated['data'];
      this.id = data['@rid'];
    });

    return ftr;
  }

  Future<Map> retrieve() => _bbCtxt.rest("GET", '/asset/$name', true);

  Future<Map> delete() => _bbCtxt.rest("DELETE", '/admin/asset/$name', true);

  Future<Map> fetch() => _bbCtxt.rest("GET", '/admin/asset', true);

}
