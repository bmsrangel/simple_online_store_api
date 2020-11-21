import '../../../app/entities/payment_type_entity.dart';

abstract class IPaymentTypesService {
  Future<List<PaymentTypeEntity>> getAllPaymentTypes();
}
