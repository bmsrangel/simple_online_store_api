abstract class ITokensService {
  Future<void> storeAccessToken(String userId, String token);
  Future<void> storeRefreshToken(String userId, String token);
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken);
  Future<String> getRefreshToken(String userId);
  Future<void> updateAccessToken(String accessToken, String userId);
}
