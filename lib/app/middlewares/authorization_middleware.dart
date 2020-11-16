import 'package:injectable/injectable.dart';

import '../../simple_online_store_api.dart';
import '../helpers/jwt_helper.dart';

@Injectable()
class AuthorizationMiddleware extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final String accessToken =
        request.raw.headers["x-authorization-token"]?.first;
    if (accessToken == null) {
      return Response.unauthorized(body: {
        "message": "Authorization token not found",
      });
    } else {
      final String userId = JwtHelper.checkAccessToken(accessToken);
      if (userId == null) {
        return request;
      } else {
        return Response.unauthorized(
            body: {"message": "Access token expired."});
      }
    }
  }
}
