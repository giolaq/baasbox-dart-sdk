part of baasbox;

class BaasBoxApiAccess {
 
  Map groups;

  Future<Map> listGroups() {

    Future ftr;
   
    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/admin/endpoints', true).
        then( (onReponse) => this.groups = onReponse['data']);
        
    return ftr;
  }
  
  Future<Map> readGroup(String groupName) {

     Future ftr;
    
     BaasBoxContext bbCtxt = new BaasBoxContext();

     ftr = bbCtxt.rest("GET", '/admin/endpoints/$groupName', true);         
     return ftr;
   }
  
  Future<Map> enableGroup(String groupName) {

       Future ftr;
      
       BaasBoxContext bbCtxt = new BaasBoxContext();

       ftr = bbCtxt.rest("PUT", '/admin/endpoints/$groupName/enabled', true);           
       return ftr;
     }
  
  Future<Map> disableGroup(String groupName) {

        Future ftr;
       
        BaasBoxContext bbCtxt = new BaasBoxContext();

        ftr = bbCtxt.rest("DELETE", '/admin/endpoints/$groupName/enabled', true);           
        return ftr;
      }
}