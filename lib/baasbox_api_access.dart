part of baasbox;

class BaasBoxApiAccess {
 
  Map groups;
  BaasBoxContext _bbCtxt;
  
  BaasBoxApiAccess() {
     this._bbCtxt = new BaasBoxContext();
  }

  Future<Map> listGroups() {

    Future ftr;
   
    ftr = _bbCtxt.rest("GET", '/admin/endpoints', true).
        then( (onReponse) => this.groups = onReponse['data']);
        
    return ftr;
  }
  
  Future<Map> readGroup(String groupName) => _bbCtxt.rest("GET", '/admin/endpoints/$groupName', true);         
    
  Future<Map> enableGroup(String groupName) => _bbCtxt.rest("PUT", '/admin/endpoints/$groupName/enabled', true);           

  Future<Map> disableGroup(String groupName) => _bbCtxt.rest("DELETE", '/admin/endpoints/$groupName/enabled', true);           

}