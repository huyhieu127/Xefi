
import 'package:flutter/cupertino.dart';

abstract class NotificationHandler{
  void fcmToken(String token);
  void notificationDirection(dynamic data);
}