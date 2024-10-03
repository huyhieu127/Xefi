import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';

class BaseAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double heightAppear;
  final Widget child;

  const BaseAppbar({super.key, this.heightAppear = 0, required this.child});

  @override
  State<BaseAppbar> createState() => _BaseAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BaseAppbarState extends State<BaseAppbar> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appbar = widget.child;
    if (_scrolledUnder) {
      appbar = Container(
        color: ColorsHelper.navy.withAlpha(50),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: appbar,
          ),
        ),
      );
    }
    return appbar;
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > widget.heightAppear;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > widget.heightAppear;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis, and should
          // not be altered based on horizontal notifications of the same
          // predicate since it could be a 2D scroller.
          break;
      }

      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }
    }
  }
}
