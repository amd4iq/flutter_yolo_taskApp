import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Services Class - Initialize Services Here and Call it in main.dart
class AppServices extends GetxService {
  // Start Services
  Future<AppServices> init() async {
    // Get Storage Init - Local Storage
    await GetStorage.init();

    return this;
  }
}

// Get Storage Instance
final getStorage = GetStorage();
