import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import '../../../app/database/hasura_database.dart';
import '../../../app/entities/product_entity.dart';
import '../../../app/exceptions/database_exception.dart';
import '../../../app/exceptions/products_not_created_exception.dart';
import '../../../app/exceptions/rest_exception.dart';
import 'i_products_repository.dart';

@LazySingleton(as: IProductsRepository)
class ProductsRepository implements IProductsRepository {
  ProductsRepository(this._database);

  final HasuraDatabase _database;

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final HasuraConnect conn = _database.conn;
      const String query = """
        query getAllProducts {
          products {
            id
            name
            short_description
            long_description
            price
            stock
            thumbnail
            discount
            category {
              id
              name
            }
          }
        }
      """;
      final response = await conn.query(query);
      final List productsMapList = response["data"]["products"] as List;
      if (productsMapList == null) {
        throw RestException();
      } else if (productsMapList.isEmpty) {
        throw ProductsNotCreatedException();
      } else {
        return productsMapList
            .map((productMap) =>
                ProductEntity.fromJson(productMap as Map<String, dynamic>))
            .toList();
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }
}
