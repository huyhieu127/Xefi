import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData iconData;
  double size;

  BaseIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.black38,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(
            iconData,
            color: Colors.white,
            size: size,
          ),
        ),
      ),
    );
  }
}
