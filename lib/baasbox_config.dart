part of baasbox;

class BaasBoxConfig {

  final String password;
  final int keystoreRes;


  /**
   * if <code>true</code> the SDK use HTTPs protocol. Default is
   * <code>false</code>.
   */
  final bool useHttps;

  /**
   * The charset used for the HTTP connection, default is <code>UTF-8</code>.
   */
  final String httpCharset;

  /**
  * The port number of the server connection, default is <code>9000</code>.
  */
  final int httpPort;

  /**
   * Sets the timeout until a connection is established. A value of zero means
   * the timeout is not used. The default value is 6000.
   */
  final int httpConnectionTimeout;

  /**
   * Sets the default socket timeout (SO_TIMEOUT) in milliseconds which is the
   * timeout for waiting for data. A timeout value of zero is interpreted as
   * an infinite timeout. The default value is zero.
   */
  final int httpSocketTimeout;

  /**
   * The domain name of the server, default is <code>"10.0.2.2</code> -refers to the localhost from emulator.
   */
  final String apiDomain;

  /**
   * The relative path of the server, default is <code>/</code>.
   */
  final String apiBasepath;

  /**
   * The BaasBox app code, default is <code>1234567890</code>.
   */
  final String appCode;

  /**
   * The authentication type used by the SDK
   * 
   * The supported authentication types.
   *  <code>BASIC_AUTHENTICATION</code>
   *  <code>SESSION_TOKEN</code>
   * default is
   * <code>SESSION_TOKEN</code>.
   */
  final String authenticationType;


  /**
   * True if session tokens are not auto refreshed upon expiration
   */
  final bool sessionTokenExpires;

  /**
   * GCM SenderIds to use for notifications
   */
  final List<String> senderIds;


  BaasBoxConfig(this.apiBasepath, this.apiDomain, this.appCode, this.authenticationType, this.httpCharset, this.httpConnectionTimeout, this.httpPort, this.httpSocketTimeout, this.keystoreRes, this.password, this.senderIds, this.sessionTokenExpires, this.useHttps);

}
