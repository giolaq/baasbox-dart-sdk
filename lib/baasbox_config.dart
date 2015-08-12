part of baasbox;

class BaasBoxConfig {
  static final String apiBasepath = "/";
  static String apiDomain = "127.0.0.1";
  static final String appCode = "1234567890";
  static final String authenticationType = "SESSION_TOKEN";
  static final String httpCharset = "UTF-8";
  static final int httpConnectionTimeout = 6000;
  static final int httpSocketTimeout = 10000;
  static final int httpPort = 9000;
  static final int keystoreRes = 0;
  static final String keyStorePass = null;
  static final bool sessionTokenExpires = false;
  static final bool useHttps = false;
  static final String password = null;



  String mPassword;
  int mKeystoreRes;


  /**
   * if <code>true</code> the SDK use HTTPs protocol. Default is
   * <code>false</code>.
   */
  bool mUseHttps;

  /**
   * The charset used for the HTTP connection, default is <code>UTF-8</code>.
   */
  String mHttpCharset;

  /**
  * The port number of the server connection, default is <code>9000</code>.
  */
  int mHttpPort;

  /**
   * Sets the timeout until a connection is established. A value of zero means
   * the timeout is not used. The default value is 6000.
   */
  int mHttpConnectionTimeout;

  /**
   * Sets the default socket timeout (SO_TIMEOUT) in milliseconds which is the
   * timeout for waiting for data. A timeout value of zero is interpreted as
   * an infinite timeout. The default value is zero.
   */
  int mHttpSocketTimeout;

  /**
   * The domain name of the server, default is <code>"10.0.2.2</code> -refers to the localhost from emulator.
   */
  String mApiDomain;

  /**
   * The relative path of the server, default is <code>/</code>.
   */
  String mApiBasepath;

  /**
   * The BaasBox app code, default is <code>1234567890</code>.
   */
  String mAppCode;

  /**
   * The authentication type used by the SDK
   * 
   * The supported authentication types.
   *  <code>BASIC_AUTHENTICATION</code>
   *  <code>SESSION_TOKEN</code>
   * default is
   * <code>SESSION_TOKEN</code>.
   */
  String mAuthenticationType;

  /**
   * True if session tokens are not auto refreshed upon expiration
   */
  bool mSessionTokenExpires;

  /**
   * GCM SenderIds to use for notifications
   */
  List<String> mSenderIds;


  BaasBoxConfig() {

    mApiBasepath = apiBasepath;
    mApiDomain = apiDomain;
    mAppCode = appCode;
    mAuthenticationType = authenticationType;
    mHttpCharset = httpCharset;
    mHttpConnectionTimeout = httpConnectionTimeout;
    mHttpSocketTimeout = httpSocketTimeout;
    mHttpPort = httpPort;
    mKeystoreRes = keystoreRes;
    mSessionTokenExpires = sessionTokenExpires;
    mUseHttps = useHttps;
    mPassword = password;


  }

}
