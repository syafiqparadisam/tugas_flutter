import 'package:flutter/material.dart';
import 'package:mobile_bab2/helper/helper.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:go_router/go_router.dart';

class DashboardFooterPage extends StatefulWidget {
  const DashboardFooterPage({super.key});

  @override
  State<DashboardFooterPage> createState() => _DashboardFooterPageState();
}

class _DashboardFooterPageState extends State<DashboardFooterPage> {
  int _currentIndex = 0;
  String? username;
  String? fullName;
  String? role;
  bool loading = true;

  final List<Widget> _pages = const [
    Center(child: Text("Beranda")),
    Center(child: Text("Tugas")),
    Center(child: Text("Profil")),
  ];

  @override
  void initState() {
    super.initState();
    _loadUser(); // panggil function async
  }

  Future<void> _loadUser() async {
    final user = await Helper.loadUser(context);
    if (user != null) {
      setState(() {
        username = user.username;
        fullName = user.fullName;
        role = user.role;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome back $fullName "),
        actions: [
          Row(
            children: [
              Text("Logout"),
              IconButton(
                color: Colors.red,
                icon: const CircleAvatar(
                  child: Icon(Icons.logout, size: 18, color: Colors.white),
                ),
                onPressed: () {
                  Helper.logout(context);
                },
              ),
            ],
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pages[_currentIndex],
            ElevatedButton(
              onPressed: () {
                context.go(Routes.dashboardSidebar);
              },
              child: const Text("Go another dashboard"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tugas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
