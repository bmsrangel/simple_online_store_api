import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import '../../../app/database/hasura_database.dart';
import '../../../app/entities/payment_type_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import 'i_payment_types_repository.dart';

@LazySingleton(as: IPaymentTypesRepository)
class PaymentTypesRepository implements IPaymentTypesRepository {
  PaymentTypesRepository(this._database);

  final HasuraDatabase _database;

  @override
  Future<List<PaymentTypeEntity>> getAllPaymentTypes() async {
    try {
      final conn = _database.conn;
      const String query = '''
        query getAllPaymentTypes {
          payment_types {
            id
            type
          }
        }
      ''';
      final response = await conn.query(query);
      final List paymentTypes = response["data"]["payment_types"] as List;
      return paymentTypes
          .map((e) => PaymentTypeEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }
}
