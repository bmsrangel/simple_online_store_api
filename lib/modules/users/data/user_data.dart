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

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._database);

  final IDatabase _database;

  @override
  Future<UserEntity> registerUser(
      RegisterUserInputModel registerUserInputModel) async {
    final conn = _database.conn;
    try {
      const String query = """
        mutation registerUser(\$name: String!, \$email: String!, \$password: String!, \$birth_date: String!) {
          insert_users_one(object: {name: \$name, email: \$email, password: \$password, birth_date: \$birth_date}) {
            id
            email
            name
            birth_date
          }
        }
      """;
      final response = await conn.mutation(query, variables: {
        "name": registerUserInputModel.name,
        "email": registerUserInputModel.email,
        "password":
            CryptHelper.generateSHA256Hash(registerUserInputModel.password),
        "birth_date": registerUserInputModel.birthDate,
      });
      return UserEntity.fromJson(
          response["data"]["insert_users_one"] as Map<String, dynamic>);
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
      query login(\$email: String!, \$password: String!) {
        users(where: {email: {_eq: \$email}, password: {_eq: \$password}}) {
          id
          name
          email
          birth_date
        }
      }
    """;
    try {
      final response = await conn.query(query, variables: {
        "email": loginUserInputModel.email,
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
