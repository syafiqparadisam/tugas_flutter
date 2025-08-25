import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  AuthResult({required this.success, required this.message, this.data});
}

class AuthService {
  static final baseUrl = Uri.parse('${dotenv.env['API_URL']}/index.php');

  static Future<AuthResult> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/index.php');
    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 200 && body['success']) {
        return AuthResult(
          success: true,
          message: body['message'],
          data: body['data'],
        );
      }

      return AuthResult(success: false, message: body['message']);
    } catch (_) {
      return AuthResult(
        success: false,
        message: 'Tidak bisa terhubung ke server',
      );
    }
  }

  static Future<AuthResult> getUser(String token) async {
    final url = Uri.parse('$baseUrl/index.php?token=$token');
    try {
      final res = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 401 && body['message'] == "Unauthorized") {
        return AuthResult(success: false, message: body['message']);
      }

      if (res.statusCode == 200 && body['success']) {
        return AuthResult(
          success: true,
          message: body['message'],
          data: body['data'],
        );
      }

      return AuthResult(success: false, message: body['message']);
    } catch (_) {
      return AuthResult(
        success: false,
        message: 'Tidak bisa terhubung ke server',
      );
    }
  }
}
