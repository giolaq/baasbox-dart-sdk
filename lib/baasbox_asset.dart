part of baasbox;

class BaasBoxAsset {
  String name;
  Map meta;
  String file;
  Map data;
  String id;

  Future create(String name, Map dataInDocument) {

    Future ftr;
    

    BaasBoxContext bbCtxt = new BaasBoxContext();

    //ftr = bbCtxt.rest("POST", '/admin/asset/', true, dataInDocument);

    ftr.then((documentCreated) { 
      this.data = documentCreated['data'];
      this.id = data['@rid'];
    });
    
    return ftr;
  }
  
  Future<Map> retrieve(String name) {}

  Future<Map> delete(String name) {}
  
  Future<Map> fetch() {}



}
