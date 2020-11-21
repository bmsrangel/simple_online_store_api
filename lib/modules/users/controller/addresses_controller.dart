import 'package:injectable/injectable.dart';

import '../../../app/entities/address_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import '../../../simple_online_store_api.dart';
import '../service/i_user_service.dart';
import '../view_models/address_input_model.dart';
import 'models/new_address_request.dart';

@LazySingleton()
class AddressesController extends ResourceController {
  AddressesController(this._service);

  final IUserService _service;

  @Operation.get('id')
  Future<Response> getAddressesByUserId(@Bind.path('id') String userId) async {
    try {
      final List<AddressEntity> userAddresses =
          await _service.getUserAddressesByUserId(userId);
      return Response.ok({
        'addresses': userAddresses.map((address) => address.toJson()).toList(),
      });
    } on DatabaseException catch (e) {
      return Response.serverError(body: {
        'message': e.message,
      });
    } on RestException {
      return Response.serverError();
    }
  }

  @Operation.post('id')
  Future<Response> addAddress(@Bind.path('id') String userId,
      @Bind.body() NewAddressRequest newAddressRequest) async {
    try {
      final AddressInputModel newAddress = mapper(newAddressRequest);
      final String newAddressId = await _service.addAddress(newAddress, userId);
      return Response.ok({
        'address_id': newAddressId,
      });
    } on DatabaseException catch (e) {
      return Response.serverError(body: {
        'message': e.message,
      });
    } on RestException {
      return Response.serverError();
    }
  }

  AddressInputModel mapper(NewAddressRequest newAddressRequest) {
    return AddressInputModel(
      street: newAddressRequest.street,
      number: newAddressRequest.number,
      complement: newAddressRequest.complement,
      city: newAddressRequest.city,
      state: newAddressRequest.state,
      country: newAddressRequest.country,
      zipCode: newAddressRequest.zipCode,
    );
  }
}
