import 'package:get_it/get_it.dart';

import '../../app/routers/i_routers_configure.dart';
import '../../simple_online_store_api.dart';
import 'controller/products_controller.dart';
import 'controller/single_product_controller.dart';

class ProductsRouters implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router
        .route("/products[?page]")
        .link(() => GetIt.I.get<ProductsController>());
    router
        .route("/products/:id")
        .link(() => GetIt.I.get<SingleProductController>());
  }
}
