import 'package:get_it/get_it.dart';

import '../../app/routers/i_routers_configure.dart';
import '../../simple_online_store_api.dart';
import 'controller/tokens_controller.dart';

class TokensRouter implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router.route("/refresh").link(() => GetIt.I.get<TokensController>());
  }
}
