import 'package:injectable/injectable.dart';
import 'package:simple_online_store_api/app/entities/product_entity.dart';
import 'package:simple_online_store_api/modules/products/data/i_products_repository.dart';

import 'i_products_service.dart';

@Injectable(as: IProductsService)
class ProductsService implements IProductsService {
  ProductsService(this._repository);

  final IProductsRepository _repository;

  @override
  Future<List<ProductEntity>> getAllProducts() {
    return _repository.getAllProducts();
  }
}
