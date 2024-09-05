import 'package:flutter/material.dart';

class ShadowHelper {
  ShadowHelper._();

  static List<Shadow> textAppName = <Shadow>[
    const Shadow(
      blurRadius: 5.0,
      color: Colors.black,
      offset: Offset(0, 2),
    ),
  ];
  static List<Shadow> textShadow = <Shadow>[
    const Shadow(
      blurRadius: 10.0,
      color: Colors.black87,
      offset: Offset(0.5, 0.5),
    ),
  ];
}
