import '../../../app/entities/user_entity.dart';
import '../view_models/login_user_input_model.dart';
import '../view_models/register_user_input_model.dart';

abstract class IUserRepository {
  Future<UserEntity> registerUser(
      RegisterUserInputModel registerUserInputModel);
  Future<UserEntity> login(LoginUserInputModel loginUserInputModel);
}
