import 'package:media_player/domain/entities/user.dart';
import 'package:media_player/domain/repositories/user_repository.dart';

import '../datasources/local_data.dart';

class LocalUserRepository implements UserRepository {
  final LocalUserDataSource localDataSource;

  LocalUserRepository(this.localDataSource);

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getCurrentUser();
  }
}
