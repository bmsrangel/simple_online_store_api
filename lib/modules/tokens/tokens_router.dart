import 'package:simple_online_store_api/app/routers/i_routers_configure.dart';

import '../../simple_online_store_api.dart';

class TokensRouter implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router.route("/refresh").link(() => null);
  }
}
