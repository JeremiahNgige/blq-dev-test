import 'package:blq_developer_test/config_keys/config_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app_theme/app_theme.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();

  await SendbirdChat.init(
    appId: Config.applicationId,
    options: SendbirdChatOptions(useCollectionCaching: true),
  );

  await SendbirdChat.connect('',
      apiHost: Config.url, accessToken: Config.apiToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        defaultThemeMode: ThemeMode.dark,
        darkTheme: AppThemeConfig.getThemeFromThemeMode(2),
        lightTheme: AppThemeConfig.getThemeFromThemeMode(1),
        builder: (context, regularTheme, darkTheme, themeMode) =>
            GetMaterialApp(
              themeMode: themeMode!,
              theme: regularTheme,
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: StackedRouter().onGenerateRoute,
              debugShowCheckedModeBanner: false,
              title: 'BLQ chat app',
              darkTheme: darkTheme,
            ));
  }
}
