import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled5/utils/service/notification_service.dart';

class FCMHelper{
  static FCMHelper helper = FCMHelper._();
  FCMHelper._();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> receiveMSG() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("============$fcmToken");

    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification != null){
        String? title = event.notification!.title;
        String? body = event.notification!.body;

        if(title != null && body != null ){
          NotificationService.notificationService.showSimpleNotification(title,body);
        // }else if(title != null && body != null && imageUrl != null){
        //   NotificationService.notificationService.showBigPictureNotification(title,body,imageUrl);
        }
      }
    },);
  }
}