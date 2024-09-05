import 'package:flutter/widgets.dart';
import 'package:xefi/src/core/helper/gradient_helper.dart';

class BoxDecorationHelper {
  BoxDecorationHelper._();

  static Decoration tagPrimary() => BoxDecoration(
        gradient: GradientHelper.primary(),
        borderRadius: BorderRadius.circular(6.0),
      );
  static Decoration tagRedPastel() => BoxDecoration(
        gradient: GradientHelper.redPastel(),
        borderRadius: BorderRadius.circular(6.0),
      );
  static Decoration tagRainbow() => BoxDecoration(
        gradient: GradientHelper.rainbow(),
        borderRadius: BorderRadius.circular(6.0),
      );
}
