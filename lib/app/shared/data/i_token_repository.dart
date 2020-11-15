abstract class ITokenRepository {
  Future<void> storeAccessToken(String userId, String token);
  Future<void> storeRefreshToken(String userId, String token);
  Future<void> storeAccessRefreshToken(
      String userId, String accessToken, String refreshToken);
}
