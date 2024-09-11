import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/home/controller/home_controller.dart';
import 'package:untitled5/utils/app_routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:untitled5/utils/helper/fcm_helper.dart';
import 'package:untitled5/utils/service/notification_service.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.notificationService.initNotification();
  tz.initializeTimeZones();
  FCMHelper.helper.receiveMSG();

  HomeController controller = Get.put(HomeController());
  runApp(
    Obx(
          () {
        controller.getData();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: app_routes,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.mode.value,
        );
      },
    ),
  );
}