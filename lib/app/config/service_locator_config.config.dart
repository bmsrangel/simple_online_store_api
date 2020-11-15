// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../database/hasura_database.dart';
import '../database/i_database.dart';
import '../shared/data/i_token_repository.dart';
import '../../modules/users/data/i_user_repository.dart';
import '../../modules/users/service/i_user_service.dart';
import '../../modules/users/controller/login_controller.dart';
import '../../modules/users/controller/register_controller.dart';
import '../shared/data/token_repository.dart';
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
  gh.factory<IDatabase>(() => HasuraDatabase());
  gh.factory<ITokenRepository>(() => TokenRepository(get<IDatabase>()));
  gh.factory<IUserRepository>(() => UserRepository(get<IDatabase>()));
  gh.factory<IUserService>(() => UserService(get<IUserRepository>()));
  gh.factory<LoginController>(
      () => LoginController(get<IUserService>(), get<ITokenRepository>()));
  gh.factory<RegisterController>(() => RegisterController(get<IUserService>()));
  return get;
}
