import 'package:flutter/material.dart';
import 'package:mobile_bab2/data/data_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:mobile_bab2/ui/auth/auth_service.dart';
import 'package:go_router/go_router.dart';

class Helper {
  static Future<UserDTO?> loadUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    if (savedToken == null) {
      // kalau token hilang → balik ke login
      if (context.mounted) {
        context.go(Routes.login);
      }
      return null;
    }

    final result = await AuthService.getUser(savedToken);

    if (!result.success) {
      // token invalid / expired → clear storage
      await prefs.clear();
      if (context.mounted) {
        context.go(Routes.login);
      }
      return null;
    }

    return UserDTO(
      username: result.data?['username'] ?? '',
      fullName: result.data?['full_name'] ?? '',
      role: result.data?['role'] ?? '',
    );
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // hapus semua
    if (context.mounted) {
      context.go(Routes.login);
    }
  }
}
