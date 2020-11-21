import 'package:redis/redis.dart';

abstract class IRedisDatabase {
  Future<Command> openConnection();
  Future<void> closeConnection();
}
