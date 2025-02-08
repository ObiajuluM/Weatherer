import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


  StreamController<String?> apiKeyChanges = StreamController<String?>();

  void setApiKey(String apiKey) {
    // init secure storage
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));

    // write api key to local storage
    storage.write(key: "api_key", value: apiKey);

    // notify stream listeners
    apiKeyChanges.add(apiKey);
  }

  /// retrieve access token from db
  Future<String?> retrieveApiKeyFromLocal() async {
    String? accessToken;

    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));

    accessToken = await storage.read(key: "api_key");
    // storage.registerListener(key: key, listener: listener);
    apiKeyChanges.add(accessToken);

    return accessToken;
  }

  void deleteApiKey() {
    // init secure storage
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));

    // delete api key
    storage.delete(key: "api_key");

    // notify stream listeners
    apiKeyChanges.add(null);
  }

