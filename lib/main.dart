import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yolo_todo/app/config/services/services.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // ensure flutter binding initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize services
  await initServices();

  // run app
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

/// Initialize services
Future initServices() async {
  // Start Services
  await Get.putAsync(() => AppServices().init());
}
