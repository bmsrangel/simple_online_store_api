import 'package:injectable/injectable.dart';
import 'package:simple_online_store_api/app/entities/payment_type_entity.dart';
import 'package:simple_online_store_api/modules/payment_types/data/i_payment_types_repository.dart';

import 'i_payment_types_service.dart';

@LazySingleton(as: IPaymentTypesService)
class PaymentTypesService implements IPaymentTypesService {
  PaymentTypesService(this._repository);

  final IPaymentTypesRepository _repository;

  @override
  Future<List<PaymentTypeEntity>> getAllPaymentTypes() {
    return _repository.getAllPaymentTypes();
  }
}
