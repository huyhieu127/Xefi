import 'package:flutter/material.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';

class BaseCircularPrg extends StatelessWidget {
  const BaseCircularPrg({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: ColorsHelper.blue,
    );
  }
}
