part of baasbox;

class BaasBoxApiSettings {
 
  List settings;
  BaasBoxContext _bbCtxt;
  
  BaasBoxApiSettings() {
    this._bbCtxt = new BaasBoxContext();
  }

  Future<Map> fetchCurrentSettings() {
    Future ftr;
    
    ftr = _bbCtxt.rest("GET", '/admin/configuration/dump.json', true).
        then( (onReponse) => this.settings = onReponse['data']);   
    
    return ftr;
  }

  Future<Map> fetchCurrentSettingsSection(String sectionName) {

      Future ftr;
     
      ftr = _bbCtxt.rest("GET", '/admin/configuration/$sectionName', true).
          then( (onReponse) => this.settings = onReponse['data']);
          
      return ftr;
    }
  
  Future<Map> updateValueInSettings(String sectionName, String key, String value) => _bbCtxt.rest("PUT", '/admin/configuration/$sectionName/$key/$value', true);           

}
