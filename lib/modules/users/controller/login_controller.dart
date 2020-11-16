import 'package:aqueduct/aqueduct.dart';
import 'package:injectable/injectable.dart';

import '../../../app/entities/user_entity.dart';
import '../../../app/exceptions/user_not_found_exception.dart';
import '../../../app/helpers/jwt_helper.dart';
import '../../../app/shared/data/i_token_repository.dart';
import '../service/i_user_service.dart';
import '../view_models/login_user_input_model.dart';
import 'models/login_request.dart';

@Injectable()
class LoginController extends ResourceController {
  LoginController(this._service, this._tokenRepository);

  final IUserService _service;
  final ITokenRepository _tokenRepository;

  @Operation.post()
  Future<Response> login(@Bind.body() LoginRequest loginRequest) async {
    try {
      final UserEntity user = await _service.login(mapper(loginRequest));
      final String accessToken =
          JwtHelper.generateAccessToken(user.id, user.birthDate);
      final String refreshToken =
          JwtHelper.generateRefreshToken(user.id, user.birthDate);
      await _tokenRepository.storeAccessRefreshToken(
          user.id, accessToken, refreshToken);
      return Response.ok({
        "user": user.toJson(),
        "token": accessToken,
      });
    } on UserNotFoundException {
      return Response.notFound(body: {
        "message": "Usuário não encontrado",
      });
    } catch (_) {
      return Response.serverError();
    }
  }

  LoginUserInputModel mapper(LoginRequest loginRequest) {
    return LoginUserInputModel(loginRequest.email, loginRequest.password);
  }
}
