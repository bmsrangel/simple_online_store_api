import 'package:injectable/injectable.dart';

import '../../../app/entities/product_entity.dart';
import '../data/i_products_repository.dart';
import 'i_products_service.dart';

@LazySingleton(as: IProductsService)
class ProductsService implements IProductsService {
  ProductsService(this._repository);

  final IProductsRepository _repository;

  @override
  Future<List<ProductEntity>> getAllProducts(int page) {
    return _repository.getAllProducts(page);
  }

  @override
  Future<ProductEntity> getProductById(String productId) {
    return _repository.getProductById(productId);
  }
}
