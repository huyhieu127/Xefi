import 'package:flutter/material.dart';

import 'indicator_top.dart';

class ToolbarBts extends StatelessWidget {
  final String title;
  final Function() onClose;

  const ToolbarBts({super.key, required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 2.0,
            child: IndicatorTop(),
          ),
          Positioned.fill(
            top: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    onClose();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
