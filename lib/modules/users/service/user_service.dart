import 'package:injectable/injectable.dart';

import '../../../app/entities/address_entity.dart';
import '../../../app/entities/user_entity.dart';
import '../data/i_user_repository.dart';
import '../view_models/address_input_model.dart';
import '../view_models/login_user_input_model.dart';
import '../view_models/register_user_input_model.dart';
import 'i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  UserService(this._repository);

  final IUserRepository _repository;

  @override
  Future<UserEntity> registerUser(
      RegisterUserInputModel registerUserInputModel) {
    return _repository.registerUser(registerUserInputModel);
  }

  @override
  Future<UserEntity> login(LoginUserInputModel loginUserInputModel) {
    return _repository.login(loginUserInputModel);
  }

  @override
  Future<List<AddressEntity>> getUserAddressesByUserId(String userId) {
    return _repository.getUserAddressesByUserId(userId);
  }

  @override
  Future<String> addAddress(
      AddressInputModel addressInputModel, String userid) {
    return _repository.addAddress(addressInputModel, userid);
  }
}
