import 'package:injectable/injectable.dart';

import '../../../app/entities/product_entity.dart';
import '../data/i_products_repository.dart';
import 'i_products_service.dart';

@LazySingleton(as: IProductsService)
class ProductsService implements IProductsService {
  ProductsService(this._repository);

  final IProductsRepository _repository;

  @override
  Future<List<ProductEntity>> getAllProducts() {
    return _repository.getAllProducts();
  }
}
