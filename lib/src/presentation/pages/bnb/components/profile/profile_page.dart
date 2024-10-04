import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/domain/entities/user/user_entity.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/base_divider_light.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserEntity? get _userEntity => prefs.loadUser();

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.white,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: _userEntity?.photoURL ?? "",
                            fit: BoxFit.cover,
                            memCacheHeight: 100,
                            width: 72,
                            height: 72,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userEntity?.displayName ?? "",
                            style: const TextStyle(
                              color: ColorsHelper.placeholder,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${_userEntity?.uid}",
                            style: const TextStyle(
                              color: ColorsHelper.placeholder,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const BaseDividerLight(),
              _button(
                label: "Chỉnh sửa thông tin",
                onTap: () {},
              ),
              const BaseDividerLight(),
              _button(
                label: "Cài đặt",
                onTap: () {},
              ),
              const BaseDividerLight(),
              _button(
                label: "Điều khoản",
                onTap: () {},
              ),
              const BaseDividerLight(),
              _button(
                label: "Về chúng tôi",
                onTap: () {},
              ),
              const BaseDividerLight(),
              _button(
                label: "Đăng xuất",
                color: ColorsHelper.redPastel,
                onTap: _logout,
              ),
              const BaseDividerLight(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    required String label,
    Color color = Colors.white,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  _logout() async {
    //Google
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    //Facebook
    await FacebookAuth.instance.logOut();
    //Remove data
    prefs.saveUser(user: null);
    prefs.setLogged(isLogged: false);
    context.router.replace(const LoginRoute());
  }
}
