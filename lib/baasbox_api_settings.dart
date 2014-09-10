part of baasbox;

class BaasBoxApiSettings {
 
  List settings;

  Future<Map> fetchCurrentSettings() {

    Future ftr;
   

    BaasBoxContext bbCtxt = new BaasBoxContext();

    ftr = bbCtxt.rest("GET", '/admin/configuration/dump.json', true).
        then( (onReponse) => this.settings = onReponse['data']);
        
    return ftr;
  }

  Future<Map> fetchCurrentSettingsSection(String sectionName) {

      Future ftr;
     

      BaasBoxContext bbCtxt = new BaasBoxContext();

      ftr = bbCtxt.rest("GET", '/admin/configuration/$sectionName', true).
          then( (onReponse) => this.settings = onReponse['data']);
          
      return ftr;
    }
  
  Future<Map> updateValueInSettings(String sectionName, String key, String value) {

       Future ftr;
      

       BaasBoxContext bbCtxt = new BaasBoxContext();

       ftr = bbCtxt.rest("PUT", '/admin/configuration/$sectionName/$key/$value', true);           
       return ftr;
     }

}
