import 'package:flutter/widgets.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/helper/shadow_helper.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsHelper.blue,
            ColorsHelper.beige,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        "X E F I",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 28,
          shadows: ShadowHelper.textAppName,
        ),
      ),
    );
  }
}
