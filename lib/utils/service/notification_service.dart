import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService{
  static NotificationService notificationService = NotificationService._();
  NotificationService._();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initNotification(){

    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings("logo");

    DarwinInitializationSettings darwinInitializationSettings =
    const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showSimpleNotification(String title,String body) {

    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails("1", "simple",
        importance: Importance.max, priority: Priority.high);

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        1, "$title", "$body", notificationDetails);
  }

  void showScheduleNotification() {

    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails("3", "Schedule");

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        "Schedule",
        "Schedule Notification is lets ",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Future<Uint8List> getByteData(String link) async {
  //   var response = await http.get(Uri.parse(link));
  //   return response.bodyBytes;
  // }

  Future<void> showBigPictureNotification(String title, String body , String imageUrl) async {

    String link = "https://t3.ftcdn.net/jpg/06/14/84/58/360_F_614845842_pNcPaSxVwBiO6hGaaSXKrQOCs6xqnijX.jpg";
    // var byte= await getByteData(link);

    // ByteArrayAndroidBitmap androidBitmap =ByteArrayAndroidBitmap(byte);
    // BigPictureStyleInformation bigPictureStyleInformation =BigPictureStyleInformation(androidBitmap);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "3", "BigPicture",);
        // styleInformation: bigPictureStyleInformation);

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.zonedSchedule(
      3, "BigPicture", "BigPicture Notification ",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showMediaStyleNotification() {

    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails("4", "sound",
        sound: RawResourceAndroidNotificationSound("music"),
        importance: Importance.max,
        priority: Priority.high,
        playSound: true);

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        4, "sound Notification", "sound", notificationDetails);
  }
}