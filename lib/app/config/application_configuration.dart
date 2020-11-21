import '../../simple_online_store_api.dart';
import 'redis_connection_configuration.dart';

class ApplicationConfiguration extends Configuration {
  ApplicationConfiguration(String filename) : super.fromFile(File(filename));

  RedisConnectionConfiguration redis;
}
