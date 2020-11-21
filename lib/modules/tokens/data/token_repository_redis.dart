import 'package:dotenv/dotenv.dart' show load, env;
import 'package:injectable/injectable.dart';
import 'package:redis/redis.dart';

import '../../../app/database/i_redis_database.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import 'i_token_repository.dart';

@LazySingleton(as: ITokenRepository)
class TokenRepositoryRedis implements ITokenRepository {
  TokenRepositoryRedis(this._database);

  final IRedisDatabase _database;

  @override
  Future<String> getLastAccessToken(String userId) async {
    try {
      final conn = await _database.openConnection();
      final String lastAccessToken = await conn.get('$userId-AT') as String;
      return lastAccessToken;
    } on RedisError catch (e) {
      print("REDIS - GET LAST ACCESS TOKEN ERROR: $e");
      throw DatabaseException(e.error);
    } catch (e) {
      print('GET LAST ACCESS TOKEN ERROR: $e');
      throw RestException();
    } finally {
      await _database?.closeConnection();
    }
  }

  @override
  Future<String> getRefreshToken(String userId) async {
    try {
      final conn = await _database.openConnection();
      final String refreshToken = await conn.get('$userId-RT') as String;
      return refreshToken;
    } on RedisError catch (e) {
      print('REDIS - GET REFRESH TOKEN ERROR: $e');
      throw DatabaseException(e.error);
    } catch (e) {
      print('GET REFRESH TOKEN ERROR: $e');
      throw RestException();
    } finally {
      await _database.closeConnection();
    }
  }

  @override
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken) async {
    try {
      load();
      final conn = await _database.openConnection();
      await conn.send_object([
        'SETEX',
        '$userId-AT',
        int.parse(env["ACCESS_TOKEN_LIFE"]),
        accessToken
      ]);
      await conn.send_object([
        'SETEX',
        '$userId-RT',
        int.parse(env["REFRESH_TOKEN_LIFE"]),
        refreshToken
      ]);
    } on RedisError catch (e) {
      print("REDIS - STORE ACCESS & REFRESH TOKEN ERROR: $e");
      throw DatabaseException(e.error);
    } catch (e) {
      print('STORE ACCESS & REFRESH TOKEN ERROR: $e');
      throw RestException();
    } finally {
      await _database?.closeConnection();
    }
  }

  @override
  Future<void> storeAccessToken(String userId, String accessToken) async {
    try {
      load();
      final conn = await _database.openConnection();
      await conn.send_object([
        'SETEX',
        '$userId-AT',
        int.parse(env["ACCESS_TOKEN_LIFE"]),
        accessToken
      ]);
    } on RedisError catch (e) {
      print('REDIS - STORE ACCESS TOKEN ERROR: $e');
      throw DatabaseException(e.error);
    } catch (e) {
      print('STORE ACCESS TOKEN ERROR: $e');
      throw RestException();
    } finally {
      await _database?.closeConnection();
    }
  }

  @override
  Future<void> updateAccessToken(String accessToken, String userId) async {
    try {
      await storeAccessToken(userId, accessToken);
    } on DatabaseException catch (e) {
      print(e.message);
      rethrow;
    } on RestException {
      rethrow;
    }
  }
}
