import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';
import '../ui/homechat/homechat_view.dart';

@StackedApp(
  //dependencies
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
  ],

  //routes
  routes: [
    MaterialRoute(page: HomeChatView, initial: true),
  ],
)
class AppSetup {}
