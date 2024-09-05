import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/button_back.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      baseAppBar: BaseAppbar(
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ButtonBack(
                  onTap: () {
                    context.router.back();
                  },
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: const Center(
        child: Text(
          "Nhập gì đó nào!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
