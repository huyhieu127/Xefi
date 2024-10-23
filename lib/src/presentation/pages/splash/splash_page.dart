import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/base_circular_prg.dart';
import 'package:xefi/src/presentation/widgets/logo_app.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _checkNotificationTray();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseBackground(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Align(child: LogoApp()),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    "Ứng dụng xem phim trực tuyến miễn phí số 1 Việt Nam, "
                    "đầy đủ mọi thể loại phim.",
                    style: TextStyle(
                      color: ColorsHelper.placeholder,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            BaseCircularPrg(),
          ],
        ),
      ),
    );
  }

  _startTimer() {
    _timer?.cancel();
    _timer = Timer(
      _duration,
      () async {
        _nextScreen();
      },
    );
  }

  _nextScreen() {
    if (prefs.getLogged()) {
      context.router.replace(const BnbRoute());
    } else {
      context.router.replace(const LoginRoute());
    }
  }

  Future<void> _checkNotificationTray() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print("FirebaseMessaging - getInitialMessage: ${message?.data}");
      if (message != null) {
        _handleNotification(message);
      } else {
        _startTimer();
      }
    });
  }

  _handleNotification(RemoteMessage message) {
    // Xử lý thông báo tại đây, tùy chỉnh theo logic của bạn
    if (message.notification != null) {
      var data = message.data;
      if (data["slug"] != null && data["slug"] != "") {
        _openPage(pageRouteInfo: PlayMovieRoute(slug: data["slug"]));
      }
    }
  }

  _openPage({
    required PageRouteInfo pageRouteInfo,
  }) {
    context.router.push(pageRouteInfo).then((onValue) {
      _startTimer();
    });
  }
}
