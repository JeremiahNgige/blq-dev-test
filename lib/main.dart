import 'package:blq_developer_test/config_keys/config_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app_theme/app_theme.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();
  try {
    final sendbird = SendbirdSdk(appId: Config.applicationId);
    // final user = await sendbird.connect(Config.userId);
    final channel = await OpenChannel.getChannel(Config.openChannel);
    await channel.enter();
  } catch (e) {
    //error
  }
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
