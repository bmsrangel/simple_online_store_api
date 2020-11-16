import '../../../simple_online_store_api.dart';

class TokensController extends ResourceController {
  @Operation.get()
  Future<Response> refreshToken(
      @Bind.header("x-authorization-token") String accessToken) async {
    return Response.ok({});
  }
}
