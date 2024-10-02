import 'package:flutter/material.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';

class BaseDividerLight extends StatelessWidget {
  const BaseDividerLight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.5,
      color: ColorsHelper.lineLight,
    );
  }
}
