import 'dart:ui';

import '../utils/color_utils.dart';

abstract class ColorsHelper {
  static const Color black = Color(0xFF021526);
  static const Color navy = Color(0xFF03346E);
  static const Color blue = Color(0xFF6EACDA);
  static const Color beige = Color(0xFFE2E2B6);
  static const Color placeholder = Color(0xFFF3F3F3);
  static const Color redPastel = Color(0xFFFF6962);
  static const Color redPastelMelon = Color(0xFFFFA9A9);
  static const Color lineLight = Color(0xCFF3F3F3);

  static List<Color> rainbows = [
    HexColor("4EA2EA"),
    HexColor("FF484DFF"),
    HexColor("#CD0EF3"),
    HexColor("#FFF640BB"),
    HexColor("FB6D64"),
  ];
}
