import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_online_store_api/app/entities/address_entity.dart';
import 'package:simple_online_store_api/modules/users/view_models/address_input_model.dart';

import '../../../app/database/i_hasura_database.dart';
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

  final IHasuraDatabase _database;

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

  @override
  Future<List<AddressEntity>> getUserAddressesByUserId(String userId) async {
    try {
      final conn = _database.conn;
      const String query = '''
      query getUserAddresses(\$userId: uuid!) {
        addresses(where: {users_id: {_eq: \$userId}}) {
          id
          street
          number
          complement
          zip_code
          city
          state
          country
        }
      }
    ''';
      final response = await conn.query(query, variables: {
        "userId": userId,
      });
      final List addressesMapList = response['data']['addresses'] as List;
      if (addressesMapList.isEmpty) {
        return [];
      } else {
        return addressesMapList
            .map((addressMap) =>
                AddressEntity.fromJson(addressMap as Map<String, dynamic>))
            .toList();
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }

  @override
  Future<String> addAddress(
      AddressInputModel addressInputModel, String userId) async {
    try {
      final conn = _database.conn;
      const String query = '''
        mutation addAddress(\$street: String!, \$number: String!, \$complement: String, \$city: String!, \$state: String!, \$country: String!, \$zip_code: String!, \$userId: uuid!) {
          insert_addresses_one(object: {street: \$street, number: \$number, complement: \$complement, city: \$city, state: \$state, country: \$country, zip_code: \$zip_code, users_id: \$userId}) {
            id
          }
        }
      ''';
      final response = await conn.mutation(query, variables: {
        "street": addressInputModel.street,
        "number": addressInputModel.number,
        "complement": addressInputModel.complement,
        "city": addressInputModel.city,
        "state": addressInputModel.state,
        "country": addressInputModel.country,
        "zip_code": addressInputModel.zipCode,
        "userId": userId,
      });
      return response['data']['insert_addresses_one']['id'] as String;
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }
}
