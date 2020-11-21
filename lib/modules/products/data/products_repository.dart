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
  Future<List<ProductEntity>> getAllProducts(int page) async {
    try {
      final HasuraConnect conn = _database.conn;
      const String query = """
        query getAllProducts(\$offset: Int!) {
          products(limit: 10, offset: \$offset) {
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
      final response = await conn.query(query, variables: {
        "offset": page * 10,
      });
      final List productsMapList = response["data"]["products"] as List;
      if (productsMapList == null) {
        throw RestException();
      } else if (page == 0 && productsMapList.isEmpty) {
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

  @override
  Future<ProductEntity> getProductById(String productId) async {
    try {
      final conn = _database.conn;
      const String query = '''
        query getProductById(\$productId: uuid!) {
          products(where: {id: {_eq: \$productId}}) {
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
      ''';
      final response = await conn.query(query, variables: {
        "productId": productId,
      });
      final List result = response["data"]["products"] as List;
      if (result.length == 1) {
        return ProductEntity.fromJson(result.first as Map<String, dynamic>);
      } else {
        return null;
      }
    } on HasuraRequestError catch (e) {
      throw DatabaseException(e.message);
    } catch (e) {
      print(e);
      throw RestException();
    }
  }
}
