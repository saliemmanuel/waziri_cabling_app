import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/index.dart';
import 'package:window_manager/window_manager.dart';

import 'desktop/screen/log/provider/test_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1200, 600),
    center: true,
    title: "BW - IMAGE",
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: ((context) => HomeProvider())),
    ],
    child: Index(isDesktop: Platform.isWindows),
  ));
}
