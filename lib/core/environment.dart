class Environment {
  static String get projectId {
    return const String.fromEnvironment('PROJECT_ID', defaultValue: "");
  }

  static String get environmentId {
    return const String.fromEnvironment('ENVIRONMENT_ID', defaultValue: "");
  }
}
