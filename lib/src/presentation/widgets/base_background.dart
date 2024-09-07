import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xefi/gen/assets.gen.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';

class BaseBackground extends StatelessWidget {
  final BaseAppbar? baseAppBar;
  final Widget child;
  const BaseBackground({super.key, this.baseAppBar, required this.child});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: baseAppBar,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  // Độ sáng giảm bằng cách thêm màu đen với opacity
                  BlendMode.darken, // Chế độ blend để giảm độ sáng
                ),
                child: Image.asset(
                  Assets.images.bgDarkMode1.path,
                  fit: BoxFit.fill,
                  cacheHeight: context.screenSize().height.toInt(),
                ),
              ),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
