import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  final Function() onTap;
  const ButtonBack({super.key, required this.onTap});

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
        child: const SizedBox(
          width: 46,
          height: 46,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
