import 'package:aqueduct/aqueduct.dart';

import '../../modules/products/products_routers.dart';
import '../../modules/tokens/tokens_router.dart';
import '../../modules/users/users_routers.dart';
import 'i_routers_configure.dart';

class RoutersConfigure {
  RoutersConfigure(this._router);

  final Router _router;
  final List<IRoutersConfigure> routers = [
    UsersRouters(),
    ProductsRouters(),
    TokensRouter(),
  ];

  void configure() => routers.forEach((route) => route.configure(_router));
}
