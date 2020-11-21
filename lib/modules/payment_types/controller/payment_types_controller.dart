import 'package:injectable/injectable.dart';

import '../../../app/entities/payment_type_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import '../../../simple_online_store_api.dart';
import '../service/i_payment_types_service.dart';

@LazySingleton()
class PaymentTypesController extends ResourceController {
  PaymentTypesController(this._service);

  final IPaymentTypesService _service;

  @Operation.get()
  Future<Response> getPaymentTypes() async {
    try {
      final List<PaymentTypeEntity> paymentTypes =
          await _service.getAllPaymentTypes();
      return Response.ok({
        "payment_types":
            paymentTypes.map((paymentType) => paymentType.toJson()).toList(),
      });
    } on DatabaseException catch (e) {
      throw Response.serverError(body: {
        "message": e.message,
      });
    } on RestException {
      throw Response.serverError();
    }
  }
}
