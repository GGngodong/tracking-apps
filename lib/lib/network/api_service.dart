import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_apps/common/base_url.dart';

class ApiService {
  final String _url = '${BaseUrl.baseUrl}/api/dev';
  String? token;

  Future<void> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? storedToken = localStorage.getString('token');
    if (storedToken != null) {
      token = jsonDecode(storedToken)['token'];
    }
  }

  Future<http.Response> auth(Map<String, dynamic> data, String apiURL) async {
    Uri fullUrl = Uri.parse(_url + apiURL);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> getData(String apiURL) async {
    Uri fullUrl = Uri.parse(_url + apiURL);
    await _getToken();
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
