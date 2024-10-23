import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xefi/src/config/notification_handler.dart';
import 'package:xefi/src/core/utils/image_url_utils.dart';

class NotificationManager {
  final NotificationHandler _navigationHandler;

  NotificationManager(this._navigationHandler);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    _setupFirebaseMessaging();
    _setupLocalNotifications();
  }

  Future<void> _setupFirebaseMessaging() async {
    var settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('FirebaseMessaging - User granted permission: '
        '${settings.authorizationStatus == AuthorizationStatus.authorized}');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    _navigationHandler.fcmToken(fcmToken ?? "");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FirebaseMessaging - onMessage: ${message?.data}");
      if (message.notification != null) {
        _showNotification(message: message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("FirebaseMessaging - onMessageOpenedApp: ${message?.data}");
      if (message.notification != null) {
        _handleDirection(data: message.data);
      }
    });
    //FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        var data = jsonDecode(notificationResponse.payload ?? "");
        print("FirebaseMessaging - selectedNotification: "
            "${data["slug"]}");
        _handleDirection(data: data);
        break;
      case NotificationResponseType.selectedNotificationAction:
        break;
    }
  }

  void _handleDirection({required data}) {
    // Xử lý thông báo tại đây, tùy chỉnh theo logic của bạn
    try {
      _navigationHandler.notificationDirection(data);
    } on Exception catch (ex) {
      print(ex);
    }
  }

  Future<void> _showNotification({required RemoteMessage message}) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    var data = message.data;
    String? imageUrl = message.notification?.android?.imageUrl;
    String? bigPicture;
    if (imageUrl != null) {
      bigPicture = await ImageUrlUtils.base64EncodeImage(imageUrl);
    }
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      //ticker: 'ticker',
      // Thêm hình ảnh vào thông báo
      styleInformation: bigPicture != null
          ? BigPictureStyleInformation(
              ByteArrayAndroidBitmap.fromBase64String(bigPicture),
              contentTitle: "${message.notification?.title} + image",
              summaryText: "${message.notification?.body} + image",
            )
          : null,
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      notification?.title ?? "Thông báo mới",
      notification?.body,
      platformDetails,
      payload: jsonEncode(data),
    );
  }
}
