import 'dart:convert';

class UserModel {
  String id;
  String email;
  String userName;
  String role;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.role,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': userName,
      'role' : role ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      email: map['email'] as String,
      userName: map['username'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
