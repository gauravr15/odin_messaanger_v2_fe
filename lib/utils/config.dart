class AppConfig {
  static Map<String, String> config = {};

  static void initializeConfig() {
    config = {
      "apiVersionUrl": "http://127.0.0.1:9010/app-mgmt/v1/checkAppVersion",
      "appVersion": "1.0",
      "appEnv": "dev",
      "appLang": "EN",
      "apiKey": "your_api_key",
    };
  }
}
