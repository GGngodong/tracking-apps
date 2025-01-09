import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:tracking_apps/common/base_url.dart';
import 'package:tracking_apps/common/failure.dart';
import 'package:tracking_apps/data/model/auth/user.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final http.Client client;

  AuthRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, UserResponse>> signUp(
      String username, String email, String password) async {
    var uri = Uri.parse('${BaseUrl.baseUrl}/api/dev/users/');
    var response = await client.get(uri);
    Logger().i('register user ${response.statusCode}');
    if (response.statusCode == 201) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(UserResponse.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserResponse>> login(String email, String password) async{
    var uri = Uri.parse('${BaseUrl.baseUrl}/api/dev/users/login');
    var response = await client.get(uri);
    Logger().i('login user ${response.statusCode}');
    if (response.statusCode)
  }
}
