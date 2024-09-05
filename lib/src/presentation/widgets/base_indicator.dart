import 'package:flutter/material.dart';

class BaseIndicator extends StatefulWidget {
  final int itemCount;
  final int currentIndex;
  final int oldIndex;
  final double offset;
  final double heightIndicator;
  final int spaceBetween;

  const BaseIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.oldIndex,
    this.offset = 0,
    this.heightIndicator = 2,
    this.spaceBetween = 4,
  });

  @override
  State<BaseIndicator> createState() => _BaseIndicatorState();
}

class _BaseIndicatorState extends State<BaseIndicator> {
  get size => widget.itemCount;

  get currentIndex => widget.currentIndex;

  get oldIndex => widget.oldIndex;

  get offset => widget.offset;

  double get heightIndicator => widget.heightIndicator;

  get spaceBetween => widget.spaceBetween;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightIndicator,
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: heightIndicator,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(heightIndicator / 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    size,
                    (index) {
                      return Container(
                        width: (constraints.maxWidth / size) - spaceBetween,
                        // height: index == currentIndex
                        //     ? heightSelected
                        //     : heightUnSelected,
                        color: index == currentIndex
                            ? Colors.white
                            : Colors.white38,
                      );
                    },
                  ),
                ),
              );
            },
          ),
          // Container(
          //   width: 100,
          //   color: ColorsHelper.navy,
          // )
        ],
      ),
    );
  }
}
