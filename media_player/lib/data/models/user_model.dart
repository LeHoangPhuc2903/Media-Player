import 'package:media_player/domain/entities/user.dart';

class UserModel extends User{    
    UserModel({
      required super.id,
      required super.username,
        
    });

    factory UserModel.fromMap(Map<String, dynamic> json) {
        return UserModel(
            id: json['id'],
            username: json['username'],
            
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'username': username,
            
        };
    }
}