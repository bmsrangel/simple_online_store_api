// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../modules/users/controller/addresses_controller.dart';
import 'application_configuration.dart';
import '../middlewares/authorization_middleware.dart';
import '../database/hasura_database.dart';
import '../database/i_hasura_database.dart';
import '../../modules/payment_types/data/i_payment_types_repository.dart';
import '../../modules/payment_types/service/i_payment_types_service.dart';
import '../../modules/products/data/i_products_repository.dart';
import '../../modules/products/service/i_products_service.dart';
import '../database/i_redis_database.dart';
import '../../modules/tokens/data/i_token_repository.dart';
import '../../modules/tokens/service/i_tokens_service.dart';
import '../../modules/users/data/i_user_repository.dart';
import '../../modules/users/service/i_user_service.dart';
import '../../modules/users/controller/login_controller.dart';
import '../../modules/payment_types/controller/payment_types_controller.dart';
import '../../modules/payment_types/data/payment_types_repository.dart';
import '../../modules/payment_types/service/payment_types_service.dart';
import '../../modules/products/controller/products_controller.dart';
import '../../modules/products/data/products_repository.dart';
import '../../modules/products/service/products_service.dart';
import '../database/redis_database.dart';
import '../../modules/users/controller/register_controller.dart';
import '../../modules/products/controller/single_product_controller.dart';
import '../../modules/tokens/data/token_repository.dart';
import '../../modules/tokens/data/token_repository_redis.dart';
import '../../modules/tokens/controller/tokens_controller.dart';
import '../../modules/tokens/service/tokens_service.dart';
import '../../modules/users/data/user_repository.dart';
import '../../modules/users/service/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<AuthorizationMiddleware>(() => AuthorizationMiddleware());
  gh.lazySingleton<IHasuraDatabase>(() => HasuraDatabase());
  gh.lazySingleton<IPaymentTypesRepository>(
      () => PaymentTypesRepository(get<HasuraDatabase>()));
  gh.lazySingleton<IPaymentTypesService>(
      () => PaymentTypesService(get<IPaymentTypesRepository>()));
  gh.lazySingleton<IProductsRepository>(
      () => ProductsRepository(get<HasuraDatabase>()));
  gh.lazySingleton<IProductsService>(
      () => ProductsService(get<IProductsRepository>()));
  gh.lazySingleton<IRedisDatabase>(
      () => RedisDatabase(get<ApplicationConfiguration>()));
  gh.lazySingleton<ITokenRepository>(
      () => TokenRepositoryRedis(get<IRedisDatabase>()));
  gh.lazySingleton<ITokensService>(
      () => TokensService(get<ITokenRepository>()));
  gh.lazySingleton<IUserRepository>(
      () => UserRepository(get<IHasuraDatabase>()));
  gh.lazySingleton<IUserService>(() => UserService(get<IUserRepository>()));
  gh.lazySingleton<LoginController>(
      () => LoginController(get<IUserService>(), get<ITokensService>()));
  gh.lazySingleton<PaymentTypesController>(
      () => PaymentTypesController(get<IPaymentTypesService>()));
  gh.lazySingleton<ProductsController>(
      () => ProductsController(get<IProductsService>()));
  gh.lazySingleton<RegisterController>(
      () => RegisterController(get<IUserService>()));
  gh.lazySingleton<SingleProductController>(
      () => SingleProductController(get<IProductsService>()));
  gh.lazySingleton<TokenRepository>(
      () => TokenRepository(get<IHasuraDatabase>()));
  gh.lazySingleton<TokensController>(
      () => TokensController(get<ITokenRepository>()));
  gh.lazySingleton<AddressesController>(
      () => AddressesController(get<IUserService>()));
  return get;
}
