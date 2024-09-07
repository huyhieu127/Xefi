import 'package:flutter/services.dart';

Future enterFullScreen() async {
  await setLandscape();
  await hideSystemBars();
}

Future exitFullScreen() async {
  await setPortrait();
  await showSystemBars();
}

Future setLandscape() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future setPortrait() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

Future hideSystemBars() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

Future showSystemBars() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
