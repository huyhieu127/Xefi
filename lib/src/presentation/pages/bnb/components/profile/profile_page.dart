import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/base_divider_light.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      baseAppBar: const BaseAppbar(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

  _logout(){
    prefs.setLogged(isLogged: false);
    context.router.replace(const LoginRoute());
  }
}
