import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  MediaQueryData mediaQuery() {
    return MediaQuery.of(this);
  }

  Size screenSize() {
    return mediaQuery().size;
  }

  EdgeInsets padding() {
    return mediaQuery().padding;
  }

  Orientation orientation() {
    return mediaQuery().orientation;
  }
}
