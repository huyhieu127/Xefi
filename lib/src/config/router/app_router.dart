import 'package:auto_route/auto_route.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        CustomRoute(
          page: LoginRoute.page,
          initial: false,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: BnbRoute.page,
          initial: false,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(page: PlayMovieRoute.page, initial: false),
        AutoRoute(page: ListMovieRoute.page, initial: false),
        CustomRoute(
          page: SearchRoute.page,
          initial: false,
          transitionsBuilder: null,
        )
      ];
}
