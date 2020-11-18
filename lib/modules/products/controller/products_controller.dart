import 'package:injectable/injectable.dart';

import '../../../app/entities/product_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import '../../../simple_online_store_api.dart';
import '../service/i_products_service.dart';

@LazySingleton()
class ProductsController extends ResourceController {
  ProductsController(this._service);

  final IProductsService _service;

  @Operation.get()
  Future<Response> getAllProducts() async {
    try {
      final List<ProductEntity> products = await _service.getAllProducts();
      return Response.ok({
        "products": products.map((product) => product.toJson()).toList(),
      });
    } on DatabaseException catch (e) {
      throw Response.serverError(body: {
        "message": e.message,
      });
    } on RestException {
      throw Response.serverError();
    }
  }
}
