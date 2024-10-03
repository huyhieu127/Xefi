import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:xefi/src/config/router/app_router.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/utils/datetime_utils.dart';
import 'package:xefi/src/core/utils/screen_utils.dart';
import 'package:xefi/src/injector.dart';

import 'firebase_options.dart';

Future main() async {
  //Config datetime
  timeago.setLocaleMessages('vi', MyCustomMessagesTimeAgo());
  //DotEnv
  await dotenv.load(fileName: ".env");
  //GetIt
  initGetItInjections();
  //Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to initialize
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());
  showSystemBars();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        //statusBarBrightness: Brightness.dark, // Dark text for status bar
        systemNavigationBarColor: Colors.transparent));

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'XEFI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsHelper.navy,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          //surface: Colors.black,
        ),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
