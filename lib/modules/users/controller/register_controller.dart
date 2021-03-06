import 'package:aqueduct/aqueduct.dart';
import 'package:injectable/injectable.dart';

import '../../../app/entities/user_entity.dart';
import '../service/i_user_service.dart';
import '../view_models/register_user_input_model.dart';
import 'models/register_request.dart';

@LazySingleton()
class RegisterController extends ResourceController {
  RegisterController(this._service);

  final IUserService _service;

  @Operation.post()
  Future<Response> registerUser(
      @Bind.body() RegisterRequest registerRequest) async {
    try {
      final UserEntity user =
          await _service.registerUser(mapper(registerRequest));
      return Response.created("", body: {
        "user": user.toJson(),
      });
    } catch (e) {
      return Response.serverError();
    }
  }
}

RegisterUserInputModel mapper(RegisterRequest registerRequest) {
  return RegisterUserInputModel(
    name: registerRequest.name,
    birthDate: registerRequest.birthDate,
    email: registerRequest.email,
    password: registerRequest.password,
  );
}
