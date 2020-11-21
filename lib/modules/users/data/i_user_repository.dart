import '../../../app/entities/address_entity.dart';
import '../../../app/entities/user_entity.dart';
import '../view_models/address_input_model.dart';
import '../view_models/login_user_input_model.dart';
import '../view_models/register_user_input_model.dart';

abstract class IUserRepository {
  Future<UserEntity> registerUser(
      RegisterUserInputModel registerUserInputModel);
  Future<UserEntity> login(LoginUserInputModel loginUserInputModel);
  Future<List<AddressEntity>> getUserAddressesByUserId(String userId);
  Future<String> addAddress(AddressInputModel addressInputModel, String userid);
}
