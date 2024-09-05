import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'colors_helper.dart';

class GradientHelper {
  GradientHelper._();

  static Gradient? primary() => const LinearGradient(
        colors: [
          ColorsHelper.blue,
          ColorsHelper.beige,
        ],
      );

  static Gradient? redPastel() => const LinearGradient(
        colors: [
          ColorsHelper.redPastel,
          ColorsHelper.redPastelMelon,
        ],
      );

  static Gradient? rainbow() => LinearGradient(
        colors: [
          HexColor("4EA2EA"),
          HexColor("FF484DFF"),
          HexColor("#CD0EF3"),
          HexColor("#FFF640BB"),
          HexColor("FB6D64"),
        ],
      );
}
