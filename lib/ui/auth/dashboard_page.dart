import 'package:flutter/material.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:mobile_bab2/ui/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? username;
  String? fullName;
  String? role;
  String? token;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');
    if (savedToken == null) {
      // kalau token hilang → balik ke login
      if (mounted) context.go(Routes.login);
      return;
    }

    setState(() {
      token = savedToken;
    });

    final result = await AuthService.getUser(savedToken);

    if (!result.success) {
      // token invalid / expired → clear storage
      await prefs.clear();
      if (mounted) context.go(Routes.login);
      return;
    }

    setState(() {
      username = result.data?['username'];
      fullName = result.data?['full_name'];
      role = result.data?['role'];
      loading = false;
    });
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // hapus semua
    if (context.mounted) {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard - $fullName')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, $fullName 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Username: $username'),
            const SizedBox(height: 8),
            Text('Token (demo): $token', overflow: TextOverflow.ellipsis),
            Text('role: $role', overflow: TextOverflow.ellipsis),
            ElevatedButton(
              onPressed: () => logout(context),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
