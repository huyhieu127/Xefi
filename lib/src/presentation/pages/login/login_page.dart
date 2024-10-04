import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/domain/entities/user/user_entity.dart';
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
  void initState() {
    super.initState();
    _authStateChanges();
  }

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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) {
                          // If the button is pressed, return green, otherwise blue
                          if (states.contains(WidgetState.pressed)) {
                            return ColorsHelper.beige;
                          }
                          return Colors.white;
                        },
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
                          return ColorsHelper.navy;
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

  _authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is null');
      } else {
        print('User: $user');
        _navigateToBnb(userEntity: gmailToUserEntity(user));
      }
    });
  }

  _navigateToBnb({required UserEntity userEntity}) {
    prefs.saveUser(user: userEntity);
    prefs.setLogged(isLogged: true);
    context.router.replace(const BnbRoute());
  }

  Future<UserCredential?> _loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Nếu người dùng hủy đăng nhập, trả về null
      if (googleUser == null) {
        print("Login canceled by user.");
        return null;
      }

      // Lấy thông tin xác thực từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Tạo credential từ token Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase bằng credential từ Google
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Login failed: $e");
      return null;
    }
  }

  Future<void> _loginWithFacebook() async {
    try {
      // Thực hiện đăng nhập với Facebook
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success && result.accessToken != null) {
        final AccessToken accessToken = result.accessToken!;
        final user = await facebookToUserEntity(accessToken);
        _navigateToBnb(userEntity: user);
      } else {
        // Đăng nhập không thành công
        print('Login failed with status: ${result.status}');
        print('Error message: ${result.message}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error during Facebook login: $e');
    }
  }
}
