import 'package:injectable/injectable.dart';

import '../../../app/helpers/jwt_helper.dart';
import '../../../simple_online_store_api.dart';
import '../data/i_token_repository.dart';

@LazySingleton()
class TokensController extends ResourceController {
  TokensController(this._tokenRepository);

  final ITokenRepository _tokenRepository;

  @Operation.get()
  Future<Response> refreshToken(
      @Bind.header("x-authorization-token") String accessToken) async {
    final String userId = JwtHelper.checkAccessToken(accessToken);
    if (userId != null) {
      final String lastAccessToken =
          await _tokenRepository.getLastAccessToken(userId);
      if (accessToken != lastAccessToken) {
        return Response.unauthorized();
      } else {
        final String refreshToken =
            await _tokenRepository.getRefreshToken(userId);
        if (JwtHelper.isRefreshTokenValid(refreshToken)) {
          final String newAccessToken =
              JwtHelper.refreshAccessToken(refreshToken);
          await _tokenRepository.updateAccessToken(newAccessToken, userId);
          final DateTime tokenExpiration =
              JwtHelper.getTokenExpiration(newAccessToken);
          return Response.ok({
            "token": newAccessToken,
            "expiration": tokenExpiration.toString(),
          });
        }
      }
    }
    return Response.unauthorized();
  }
}
