import 'package:get_it/get_it.dart';

import 'app/config/service_locator_config.dart';
import 'app/database/hasura_database.dart';
import 'app/routers/routers_configure.dart';
import 'simple_online_store_api.dart';

class SimpleOnlineStoreApiChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    GetIt.instance.registerLazySingleton(() => HasuraDatabase());
    configureDependencies();
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/images/*").link(() => FileController("public/"));

    RoutersConfigure(router).configure();

    return router;
  }
}
