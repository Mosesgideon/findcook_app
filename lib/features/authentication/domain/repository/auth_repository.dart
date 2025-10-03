import '../../data/models/auth_response.dart';

abstract class AuthRepository{
  Future<void>login(String email,String password);

  Future<void>register(AuthPayload payload);
  Future<void>logout();
  Future<void>resetpassword(String email);
}