import 'package:media_player/domain/entities/user.dart';
import 'package:media_player/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository userRepository;

  GetCurrentUser(this.userRepository);

  Future<User?> call() async {
    return await userRepository.getCurrentUser();
  }
}