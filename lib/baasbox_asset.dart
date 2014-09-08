part of baasbox;

class BaasBoxAsset {
  String name;
  Map meta;
  String file;
  Map data;
  String id;

  BaasBoxAsset(this.name, this.meta);

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

  Future<Map> retrieve() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/asset/$name', true);
    return ftr;
  }

  Future<Map> delete() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("DELETE", '/admin/asset/$name', true);
    return ftr;

  }

  Future<Map> fetch() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/admin/asset', true);
    return ftr;
  }


}
