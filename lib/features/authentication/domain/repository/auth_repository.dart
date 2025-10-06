import '../../data/models/AuthSuccessResponse.dart';
import '../../data/models/auth_response.dart';

abstract class AuthRepository{
  Future<AuthSuccessResponse>login(String email,String password);

  Future<AuthSuccessResponse>register(AuthPayload payload);
  Future<void>logout();
  Future<void>resetpassword(String email);
}