import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import '../../../app/database/i_database.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/refresh_token_not_found_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import 'i_token_repository.dart';

@LazySingleton(as: ITokenRepository)
class TokenRepository implements ITokenRepository {
  TokenRepository(this._database);

  final IDatabase _database;

  @override
  Future<void> storeAccessToken(String userId, String token) async {
    final conn = _database.conn;
    const String query = """
      mutation insertAccessToken(\$accessToken: String!, \$userId: uuid!) {
        insert_tokens_one(object: {access_token: \$accessToken, users_id: \$userId}, on_conflict: {constraint: tokens_users_id_key, update_columns: access_token}) {
          access_token
        }
      }
    """;
    try {
      await conn.mutation(query, variables: {
        "accessToken": token,
        "userId": userId,
      });
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<void> storeRefreshToken(String userId, String token) async {
    final conn = _database.conn;
    const String query = """
      mutation insertRefreshToken(\$refreshToken: String!, \$userId: uuid!) {
        insert_tokens_one(object: {refresh_token: \$refreshToken, users_id: \$userId}, on_conflict: {constraint: tokens_users_id_key, update_columns: refresh_token}) {
          refresh_token
        }
      }
    """;
    try {
      await conn.mutation(query, variables: {
        "refreshToken": token,
        "userId": userId,
      });
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken) async {
    final conn = _database.conn;
    const String query = """
      mutation insertAccessRefreshTokens(\$accessToken: String!, \$refreshToken: String!, \$userId: uuid!) {
        access: insert_tokens_one(object: {access_token: \$accessToken, users_id: \$userId}, on_conflict: {constraint: tokens_users_id_key, update_columns: access_token}) {
          access_token
        }
        refresh: insert_tokens_one(object: {refresh_token: \$refreshToken, users_id: \$userId}, on_conflict: {constraint: tokens_users_id_key, update_columns: refresh_token}) {
          refresh_token
        }
      }
    """;
    try {
      await conn.mutation(query, variables: {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "userId": userId,
      });
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<String> getRefreshToken(String userId) async {
    try {
      final HasuraConnect conn = _database.conn;
      const String query = """
        query getRefreshToken(\$userId: uuid!) {
          tokens(where: {users_id: {_eq: \$userId}}) {
            refresh_token
          }
        }
      """;
      final response = await conn.query(query, variables: {
        "userId": userId,
      });
      final List tokenMapList = response["data"]["tokens"] as List;
      if (tokenMapList.isEmpty) {
        throw RefreshTokenNotFoundException();
      } else {
        return tokenMapList.first["refresh_token"] as String;
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<void> updateAccessToken(String accessToken, String userId) async {
    try {
      final HasuraConnect conn = _database.conn;
      const String query = """
        mutation updateAccessToken(\$access_token: String!, \$userId: uuid!) {
          update_tokens(where: {users_id: {_eq: \$userId}}, _set: {access_token: \$access_token}) {
            affected_rows
          }
        }
      """;
      await conn.mutation(query, variables: {
        "access_token": accessToken,
        "userId": userId,
      });
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<String> getLastAccessToken(String userId) async {
    try {
      final conn = _database.conn;
      const String query = """
        query getLastAccessToken(\$userId: uuid) {
          tokens(where: {users_id: {_eq: \$userId}}) {
            access_token
          }
        }
      """;
      final response = await conn.query(query);
      final List tokensList = response["data"]["tokens"] as List;
      if (tokensList.isNotEmpty) {
        return tokensList.first["access_token"] as String;
      } else {
        throw RefreshTokenNotFoundException();
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
