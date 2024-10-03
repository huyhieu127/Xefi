import 'package:flutter/material.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return const BaseBackground(
      baseAppBar: BaseAppbar(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Yêu thích",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      child: SizedBox(),
    );
  }
}
