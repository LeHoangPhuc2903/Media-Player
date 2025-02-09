import 'package:media_player/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getCurrentUser();
  
}