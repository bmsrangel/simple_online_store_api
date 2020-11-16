// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../middlewares/authorization_middleware.dart';
import '../database/hasura_database.dart';
import '../database/i_database.dart';
import '../../modules/products/data/i_products_repository.dart';
import '../../modules/products/service/i_products_service.dart';
import '../../modules/tokens/data/i_token_repository.dart';
import '../../modules/tokens/service/i_tokens_service.dart';
import '../../modules/users/data/i_user_repository.dart';
import '../../modules/users/service/i_user_service.dart';
import '../../modules/users/controller/login_controller.dart';
import '../../modules/products/controller/products_controller.dart';
import '../../modules/products/data/products_repository.dart';
import '../../modules/products/service/products_service.dart';
import '../../modules/users/controller/register_controller.dart';
import '../../modules/tokens/data/token_repository.dart';
import '../../modules/tokens/service/tokens_service.dart';
import '../../modules/users/data/user_data.dart';
import '../../modules/users/service/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AuthorizationMiddleware>(() => AuthorizationMiddleware());
  gh.factory<IDatabase>(() => HasuraDatabase());
  gh.factory<IProductsRepository>(
      () => ProductsRepository(get<HasuraDatabase>()));
  gh.factory<IProductsService>(
      () => ProductsService(get<IProductsRepository>()));
  gh.factory<ITokenRepository>(() => TokenRepository(get<IDatabase>()));
  gh.factory<ITokensService>(() => TokensService(get<ITokenRepository>()));
  gh.factory<IUserRepository>(() => UserRepository(get<IDatabase>()));
  gh.factory<IUserService>(() => UserService(get<IUserRepository>()));
  gh.factory<LoginController>(
      () => LoginController(get<IUserService>(), get<ITokensService>()));
  gh.factory<ProductsController>(
      () => ProductsController(get<IProductsService>()));
  gh.factory<RegisterController>(() => RegisterController(get<IUserService>()));
  return get;
}
