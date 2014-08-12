
part of baasbox;

class BaasBoxContext {
  
  static BaasBoxContext _baasboxcontext;
  
  final BaasBoxConfig config;
  
  factory BaasBoxContext(BaasBoxConfig config) {
    if  ( _baasboxcontext == null ) {
      _baasboxcontext = new BaasBoxContext._internal(config);
    }
    return _baasboxcontext;
  }

  BaasBoxContext._internal(this.config);

}