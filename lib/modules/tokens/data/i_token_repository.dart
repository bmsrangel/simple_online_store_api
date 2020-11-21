abstract class ITokenRepository {
  Future<void> storeAccessToken(String userId, String accessToken);
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken);
  Future<String> getLastAccessToken(String userId);
  Future<String> getRefreshToken(String userId);
  Future<void> updateAccessToken(String accessToken, String userId);
}
