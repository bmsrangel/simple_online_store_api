import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import '../../../app/database/i_database.dart';
import '../../../app/entities/user_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import '../../../app/exceptions/user_not_found_exception.dart';
import '../../../app/helpers/crypt_helper.dart';
import '../view_models/login_user_input_model.dart';
import '../view_models/register_user_input_model.dart';
import 'i_user_repository.dart';

@Injectable(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._database);

  final IDatabase _database;

  @override
  Future<UserEntity> registerUser(
      RegisterUserInputModel registerUserInputModel) async {
    final conn = _database.conn;
    try {
      const String query = """
        mutation registerUser(\$name: String!, \$email: String!, \$username: String!, \$password: String!) {
          insert_users(objects: {name: \$name, email: \$email, username: \$username, password: \$password}) {
            returning {
              id
              name
              username
              email
            }
          }
        }

      """;
      final response = await conn.mutation(query, variables: {
        "name": registerUserInputModel.name,
        "username": registerUserInputModel.username,
        "email": registerUserInputModel.email,
        "password":
            CryptHelper.generateSHA256Hash(registerUserInputModel.password),
      });
      return UserEntity.fromJson(response["data"]["insert_users"]["returning"]
          [0] as Map<String, dynamic>);
    } on HasuraRequestError catch (e) {
      print(e.exception);
      print(e.message);
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<UserEntity> login(LoginUserInputModel loginUserInputModel) async {
    final conn = _database.conn;
    const String query = """
      query getUser(\$username: String!, \$password: String!) {
        users(where: {username: {_eq: \$username}, password: {_eq: \$password}}) {
          id
          name
          email
          username
        }
      }

    """;
    try {
      final response = await conn.query(query, variables: {
        "username": loginUserInputModel.username,
        "password":
            CryptHelper.generateSHA256Hash(loginUserInputModel.password),
      });
      final List usersData = response["data"]["users"] as List;
      if (usersData == null || usersData.isEmpty) {
        throw UserNotFoundException();
      } else {
        return UserEntity.fromJson(usersData.first as Map<String, dynamic>);
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }
}
