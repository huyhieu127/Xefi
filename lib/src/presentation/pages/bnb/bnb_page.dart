import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xefi/gen/assets.gen.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/presentation/pages/bnb/components/favorite/favorite_page.dart';
import 'package:xefi/src/presentation/pages/bnb/components/history/history_page.dart';
import 'package:xefi/src/presentation/pages/bnb/components/profile/profile_page.dart';

import 'components/home/home_page.dart';

@RoutePage()
class BnbPage extends StatefulWidget {
  const BnbPage({super.key});

  @override
  State<BnbPage> createState() => _BnbPageState();
}

class _BnbPageState extends State<BnbPage> {
  final List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: _widgetNavigationBar(currentIndex: _currentIndex),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _widgetNavigationBar({required int currentIndex}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _widgetNavigationItem(
                    iconData: Icons.home_rounded,
                    label: 'Trang chủ',
                    index: 0,
                  ),
                  _widgetNavigationItem(
                    iconData: Icons.favorite_outline_rounded,
                    label: 'Yêu thích',
                    index: 1,
                  ),
                  _widgetNavigationItem(
                    iconData: Icons.watch_later_outlined,
                    label: 'Lịch sử',
                    index: 2,
                  ),
                  _widgetNavigationItem(
                    iconData: Icons.person_outline_rounded,
                    label: 'Tài khoản',
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetNavigationItem({
    required IconData iconData,
    required String label,
    required int index,
  }) {
    final isSelected = index == _currentIndex;
    const colorSelected = ColorsHelper.blue;
    const colorUnselected = ColorsHelper.placeholder;
    final color = isSelected ? colorSelected : colorUnselected;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onTabChange(index);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            Text(
              label,
              style: TextStyle(
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabChange(int index) {
    _pageController.jumpToPage(index);
  }
}
