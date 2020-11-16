import 'package:get_it/get_it.dart';

import '../../app/middlewares/authorization_middleware.dart';
import '../../app/routers/i_routers_configure.dart';
import '../../simple_online_store_api.dart';
import 'controller/products_controller.dart';

class ProductsRouters implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router
        .route("/products")
        .link(() => GetIt.I.get<AuthorizationMiddleware>())
        .link(() => GetIt.I.get<ProductsController>());
  }
}
