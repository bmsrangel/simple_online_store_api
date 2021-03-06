import '../../../app/entities/product_entity.dart';

abstract class IProductsService {
  Future<List<ProductEntity>> getAllProducts(int page);
  Future<ProductEntity> getProductById(String productId);
}
