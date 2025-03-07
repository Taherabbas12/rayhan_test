// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'error_message.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initializeNotifications() async {
//   // إعدادات Android
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   // إعدادات iOS
//   final DarwinInitializationSettings initializationSettingsIOS =
//       DarwinInitializationSettings(
//     requestAlertPermission: true, // طلب إذن لإظهار التنبيهات
//     requestBadgePermission: true, // طلب إذن لإظهار الشارات
//     requestSoundPermission: true, // طلب إذن لتشغيل الأصوات
//   );

//   // دمج إعدادات Android وiOS
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );

//   // تهيئة الإشعارات
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) async {
//       // يمكنك التعامل مع استجابات المستخدم للإشعارات هنا
//       logger.i('استجابة للمستخدم: ${response.payload}');
//     },
//   );
// }
