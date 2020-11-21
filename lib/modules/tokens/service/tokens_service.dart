import 'package:injectable/injectable.dart';

import '../data/i_token_repository.dart';
import 'i_tokens_service.dart';

@LazySingleton(as: ITokensService)
class TokensService implements ITokensService {
  TokensService(this._repository);

  final ITokenRepository _repository;

  @override
  Future<String> getRefreshToken(String userId) {
    return _repository.getRefreshToken(userId);
  }

  @override
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken) {
    return _repository.storeAccessRefreshToken(
        userId, accessToken, refreshToken);
  }

  @override
  Future<void> storeAccessToken(String userId, String token) {
    return _repository.storeAccessToken(userId, token);
  }

  @override
  Future<void> updateAccessToken(String accessToken, String userId) {
    return _repository.updateAccessToken(accessToken, userId);
  }

  @override
  Future<String> getLastAccessToken(String userId) {
    return _repository.getLastAccessToken(userId);
  }
}
