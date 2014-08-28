part of baasbox;


class BaasBoxCollection {

  String name;

  BaasBoxCollection(this.name);

  Future create() {

    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("POST", '/admin/collection/$name', true);
    return ftr;
  }


  Future delete() {
    Future ftr;

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("DELETE", '/admin/collection/$name', true);
    return ftr;
  }

}
