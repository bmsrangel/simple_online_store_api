import '../../../app/entities/product_entity.dart';

abstract class IProductsRepository {
  Future<List<ProductEntity>> getAllProducts(int page);
}
