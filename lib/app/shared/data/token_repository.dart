import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import '../../database/i_database.dart';
import '../../exceptions/database_exception.dart';
import '../../exceptions/rest_exception.dart';
import 'i_token_repository.dart';

@Injectable(as: ITokenRepository)
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
}
