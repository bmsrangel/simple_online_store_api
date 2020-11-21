import 'package:aqueduct/aqueduct.dart';
import 'package:get_it/get_it.dart';

import '../../app/middlewares/authorization_middleware.dart';
import '../../app/routers/i_routers_configure.dart';
import 'controller/addresses_controller.dart';
import 'controller/login_controller.dart';
import 'controller/register_controller.dart';

class UsersRouters implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router
        .route("/users/register")
        .link(() => GetIt.I.get<RegisterController>());
    router.route("/users").link(() => GetIt.I.get<LoginController>());
    router
        .route("/users/:id/addresses")
        .link(() => GetIt.I.get<AuthorizationMiddleware>())
        .link(() => GetIt.I.get<AddressesController>());
  }
}
