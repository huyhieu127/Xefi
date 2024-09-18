import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/search/search_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/button_back.dart';
import 'package:xefi/src/presentation/widgets/item_movie_grid.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit _cubit = injector<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BaseBackground(
        baseAppBar: BaseAppbar(
          child: SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ButtonBack(
                    onTap: () {
                      context.router.popForced();
                    },
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return SearchInputWidget(
                        initialValue: _cubit.keyword,
                        onTextChange: (String text) {
                          _cubit.getSearch(keyword: text);
                        },
                      );
                    }
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return const Center(
                child: Text(
                  "Nhập nội dung để tìm kiếm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            } else if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (state is SearchSuccess) {
              if (state.movies.isEmpty) {
                var text = _cubit.keyword.isEmpty
                    ? "Nhập nội dung để tìm kiếm"
                    : "Không tìm thấy nội dung, từ khóa:\n \"${_cubit.keyword}\".";
                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return _gridMovie(state);
              }
            } else {
              return const Center(
                child: Text(
                  "Has an error!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void navigateToDetail({
    required BuildContext context,
    required MovieGenreEntity movieGenre,
  }) {
    if ((movieGenre.slug ?? "").isNotEmpty) {
      context.router.push(
        PlayMovieRoute(slug: movieGenre.slug!),
      );
    }
  }

  Widget _gridMovie(SearchSuccess state) {
    final movies = state.movies;
    final domainLoadImage = state.domainImage;

    final bottom = context.padding().bottom;
    return SafeArea(
      bottom: false,
      child: GridView.builder(
        padding: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
          bottom: 16 + bottom,
        ),
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          final item = movies[index];
          return ItemMovieGrid(
            posterUrl: '$domainLoadImage/${item.posterUrl}',
            name: item.name,
            originName: item.originName,
            year: item.year,
            time: item.time,
            episodeCurrent: item.episodeCurrent,
            quality: item.quality,
            lang: item.lang,
            isCinema: item.chieuRap,
            modifiedTime: item.modified?.time,
            onTap: () {
              navigateToDetail(context: context, movieGenre: item);
            },
          );
        },
      ),
    );
  }
}

class SearchInputWidget extends StatefulWidget {
  final String initialValue;
  final Function(String text) onTextChange;

  const SearchInputWidget({
    super.key,
    required this.initialValue,
    required this.onTextChange,
  });

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;
  final _duration = const Duration(milliseconds: 500);

  bool _isDeleteVisible = false;

  @override
  void initState() {
    super.initState();
    print("initState: ${widget.initialValue}");
    _controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: true,
      onChanged: _onTextChanged,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: "Nhập từ khóa",
        hintStyle: const TextStyle(fontSize: 16),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.search),
        ),
        prefixIconColor: Colors.white,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            opacity: _isDeleteVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: IconButton(
              onPressed: () {
                _onDelete();
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ),
        suffixIconColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  void _onTextChanged(String text) {
    if (!_isDeleteVisible && text.isNotEmpty) {
      setState(() {
        _isDeleteVisible = true;
      });
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    if (text.isEmpty) {
      widget.onTextChange("");
    } else {
      _debounce = Timer(
        _duration,
        () {
          widget.onTextChange(text);
        },
      );
    }
  }

  void _onDelete() {
    setState(() {
      _isDeleteVisible = false;
      _controller.text = "";
    });
  }
}
