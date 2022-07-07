enum Environment { dev, prod }

class ConstantEnvironment {
  static Map<String, dynamic>? config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        config = Config.dev;
        break;
      case Environment.prod:
        config = Config.prod;
        break;
    }
  }


  // add new conmmit


  static get baseUrl {
    return config![Config.baseURL];
  }

  static get baseNewUrl {
    return config![Config.baseNewURL];
  }
  static get baseUrl1 {
    return config![Config.baseURL1];
  }
}

class Config {
  static const baseURL = "BASE_URL";
  static const baseNewURL = "BASE_NEW_URL";
  static const baseURL1 = "BASE_URL_ONE";

  static Map<String, dynamic> dev = {
    baseURL: "https://dev1.example.com/",
    baseNewURL: "https://dev2.example.com/",
    baseURL1: "dev",
  };

  static Map<String, dynamic> prod = {
    baseURL: "https://prod1.example.com/",
    baseNewURL: "https://prod2.example.com/",
    baseURL1: "prod"
  };
}
