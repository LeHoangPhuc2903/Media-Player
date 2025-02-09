import 'package:media_player/data/datasources/local.dart';
import 'package:media_player/domain/entities/user.dart';
import 'package:media_player/domain/repositories/user_repository.dart';
import 'package:media_player/data/models/user_model.dart';

class LocalUserRepository implements UserRepository {
  final LocalUserDataSource localDataSource;

  LocalUserRepository(this.localDataSource);

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getCurrentUser();
  }
}
