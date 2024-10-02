import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/logo_app.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
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
            Padding(
              padding: const EdgeInsets.all(42.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.flutter_dash_rounded),
                    onPressed: _loginWithGoogle,
                    label: const Text(
                      "Đăng nhập với tài khoản Google",
                      style: TextStyle(
                        color: ColorsHelper.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.facebook_rounded,
                      color: Colors.white,
                    ),
                    onPressed: _loginWithFacebook,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.blue;
                      }),
                    ),
                    label: const Text(
                      "Đăng nhập với tài khoản Facebook",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginWithGoogle() {
    prefs.setLogged(isLogged: true);
    context.router.replace(const BnbRoute());
  }

  _loginWithFacebook() {
    prefs.setLogged(isLogged: true);
    context.router.replace(const BnbRoute());
  }
}
