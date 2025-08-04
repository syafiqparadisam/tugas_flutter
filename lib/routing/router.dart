import 'package:go_router/go_router.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:mobile_bab2/ui/auth/login_page.dart';
import 'package:mobile_bab2/ui/profile/biodata_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.dashboard, builder: (context, state) => BiodataPage()),
  ],
);
