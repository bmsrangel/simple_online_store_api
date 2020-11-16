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
}
