import 'package:injectable/injectable.dart';

import '../../../app/entities/product_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import '../../../simple_online_store_api.dart';
import '../service/i_products_service.dart';

@LazySingleton()
class SingleProductController extends ResourceController {
  SingleProductController(this._productsService);

  final IProductsService _productsService;

  @Operation.get('id')
  Future<Response> getSingleProduct(@Bind.path('id') String productId) async {
    try {
      final ProductEntity product =
          await _productsService.getProductById(productId);
      if (product != null) {
        return Response.ok(product.toJson());
      } else {
        return Response.notFound(body: {'message': 'Product not found'});
      }
    } on DatabaseException catch (e) {
      throw Response.serverError(body: {
        "message": e.message,
      });
    } on RestException {
      throw Response.serverError();
    }
  }
}
