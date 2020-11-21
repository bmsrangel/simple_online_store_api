import 'package:simple_online_store_api/app/entities/payment_type_entity.dart';

abstract class IPaymentTypesRepository {
  Future<List<PaymentTypeEntity>> getAllPaymentTypes();
}
