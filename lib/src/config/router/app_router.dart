import 'package:auto_route/auto_route.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: PlayMovieRoute.page, initial: false),
        AutoRoute(page: ListMovieRoute.page, initial: false),
        CustomRoute(
          page: SearchRoute.page,
          initial: false,
          transitionsBuilder: null,
        )
      ];
}
