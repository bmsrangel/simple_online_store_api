import 'package:get_it/get_it.dart';

import '../../app/routers/i_routers_configure.dart';
import '../../simple_online_store_api.dart';
import 'controller/payment_types_controller.dart';

class PaymentTypesRouters implements IRoutersConfigure {
  @override
  void configure(Router router) {
    router.route("/payments").link(() => GetIt.I.get<PaymentTypesController>());
  }
}
