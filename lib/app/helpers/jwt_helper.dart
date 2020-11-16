import 'package:dotenv/dotenv.dart' show load, env;
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  static String generateAccessToken(String id, String email) {
    load();
    final JwtClaim accessTokenClaim = JwtClaim(
      payload: {"id": id, "email": email},
      maxAge: Duration(seconds: int.parse(env["ACCESS_TOKEN_LIFE"])),
    );
    final String accessToken =
        issueJwtHS256(accessTokenClaim, env["ACCESS_TOKEN_SECRET"]);
    return accessToken;
  }

  static String generateRefreshToken(String id, String email) {
    load();
    final JwtClaim accessTokenClaim = JwtClaim(
      payload: {"id": id, "email": email},
      maxAge: Duration(seconds: int.parse(env["REFRESH_TOKEN_LIFE"])),
    );
    final String accessToken =
        issueJwtHS256(accessTokenClaim, env["REFRESH_TOKEN_SECRET"]);
    return accessToken;
  }

  static String checkAccessToken(String accessToken) {
    final String accessTokenSecret = env["ACCESS_TOKEN_SECRET"];
    try {
      load();
      final JwtClaim accessTokenClaim =
          verifyJwtHS256Signature(accessToken, accessTokenSecret);
      accessTokenClaim.validate();
      return null;
    } on JwtException catch (e) {
      if (e.message == "JWT token expired!") {
        final JwtClaim accessTokenClaim =
            verifyJwtHS256Signature(accessToken, accessTokenSecret);
        final String userId = accessTokenClaim.payload["id"] as String;
        return userId;
      } else {
        rethrow;
      }
    }
  }

  static String checkRefreshToken(String refreshToken) {
    load();
    final String refreshTokenSecret = env["REFRESH_TOKEN_SECRET"];
    final JwtClaim refreshTokenClaim =
        verifyJwtHS256Signature(refreshToken, refreshTokenSecret);
    refreshTokenClaim.validate();
    return null;
  }

  static String refreshAccessToken(String refreshToken) {
    load();
    final String accessTokenSecret = env["ACCESS_TOKEN_SECRET"];
    final Duration accessTokenDuration =
        Duration(seconds: int.parse(env["ACCESS_TOKEN_LIFE"]));
    final String refreshTokenSecret = env["REFRESH_TOKEN_SECRET"];
    final JwtClaim refreshTokenClaim =
        verifyJwtHS256Signature(refreshToken, refreshTokenSecret);

    final JwtClaim newAccessTokenClaim = JwtClaim(
        payload: refreshTokenClaim.payload, maxAge: accessTokenDuration);
    final String newAcessToken =
        issueJwtHS256(newAccessTokenClaim, accessTokenSecret);
    return newAcessToken;
  }

  static DateTime getTokenExpiration(String token, {bool refresh = false}) {
    load();
    final String tokenSecret =
        refresh ? env["REFRESH_TOKEN_SECRET"] : env["ACCESS_TOKEN_SECRET"];
    final JwtClaim tokenClaim = verifyJwtHS256Signature(token, tokenSecret);
    return tokenClaim.expiry;
  }
}
