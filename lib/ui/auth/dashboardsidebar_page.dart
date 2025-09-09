import 'package:flutter/material.dart';
import 'package:mobile_bab2/helper/helper.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_bab2/routing/routes.dart';

class DashboardSidebarPage extends StatefulWidget {
  const DashboardSidebarPage({super.key});

  @override
  State<DashboardSidebarPage> createState() => _DashboardSidebarPageState();
}

class _DashboardSidebarPageState extends State<DashboardSidebarPage> {
  int _selectedIndex = 0;
  String? username;
  String? fullName;
  String? role;
  bool loading = true;

  Widget _getContent() {
    switch (_selectedIndex) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Beranda"),
              ElevatedButton(
                onPressed: () {
                  context.go(Routes.dashboardFooter);
                },
                child: const Text("Go another dashboard"),
              ),
            ],
          ),
        );
      case 1:
        return Center(child: Text("Nilai / Statistik"));
      case 2:
        return Center(child: Text("Pengaturan"));
      default:
        return Center(child: Text("Lainnya"));
    }
  }

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
    final drawerMenu = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(fullName ?? ''),
            accountEmail: Text("$username@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            selected: _selectedIndex == 0,
            onTap: () {
              setState(() => _selectedIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistik'),
            selected: _selectedIndex == 1,
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            selected: _selectedIndex == 2,
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome back $fullName"),
        actions: [
          Row(
            children: [
              Text("Logout"),
              IconButton(
                icon: const CircleAvatar(child: Icon(Icons.logout, size: 18)),
                onPressed: () {
                  Helper.logout(context);
                },
              ),
            ],
          ),
        ],
      ),
      drawer: drawerMenu,
      body: _getContent(),
    );
  }
}
