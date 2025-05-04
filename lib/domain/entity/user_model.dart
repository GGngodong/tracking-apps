import 'dart:convert';

class UserModel {
  String id;
  String email;
  String userName;
  String role;
  String division;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.role,
    required this.division,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': userName,
      'role': role ?? '',
      'division': division ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      email: map['email'] as String,
      userName: map['username'] as String,
      role: map['role'] as String,
      division: map['division'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
