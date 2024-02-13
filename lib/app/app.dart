import 'package:blq_developer_test/services/openHandlerService.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';
import '../ui/homechat/homechat_view.dart';

@StackedApp(
  //dependencies
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: MyOpenChannelHandler)
  ],

  //routes
  routes: [
    MaterialRoute(page: HomeChatView, initial: true),
  ],
)
class AppSetup {}
