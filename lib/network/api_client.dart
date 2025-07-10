import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ApiClient {
  static Future<http.Response> request(
    Future<http.Response> Function(Map<String, String> headers) fn,
  ) async {
    final token = await SharedPreferencesService.instance
        .getData(PreferenceKey.authToken);

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await fn(headers);

    if (response.statusCode == 401) {
      await _handleExpiredSession();
      throw Exception('Session expired');
    }

    return response;
  }

  static Future<void> _handleExpiredSession() async {
    await SharedPreferencesService.instance.removeData(PreferenceKey.authToken);

    final ctx = navigatorKey.currentContext;
    if (ctx != null) {
      ctx.read<LoginBloc>().add(LogoutButtonPressed(authToken: ''));
    }
    if (ctx != null) {
      GoRouter.of(ctx).go('/login');
    }

    if (ctx != null) {
      showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Session expired'),
          content: const Text('Your session has expired. Please log in again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
