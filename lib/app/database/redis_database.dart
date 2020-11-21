import 'package:injectable/injectable.dart';
import 'package:redis/redis.dart';

import '../config/application_configuration.dart';
import 'i_redis_database.dart';

@LazySingleton(as: IRedisDatabase)
class RedisDatabase implements IRedisDatabase {
  RedisDatabase(this._configuration) {
    _conn = RedisConnection();
  }

  final ApplicationConfiguration _configuration;

  RedisConnection _conn;

  @override
  Future<Command> openConnection() {
    final databaseConfiguration = _configuration.redis;
    return _conn.connect(
        databaseConfiguration.host, databaseConfiguration.port);
  }

  @override
  Future<void> closeConnection() {
    return _conn.close();
  }
}
