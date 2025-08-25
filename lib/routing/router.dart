import 'package:go_router/go_router.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:mobile_bab2/ui/auth/dashboard_page.dart';
import 'package:mobile_bab2/ui/auth/login_page.dart';

GoRouter createRouter(String? token) {
  return GoRouter(
    initialLocation: token == null ? Routes.login : Routes.dashboard,
    routes: [
      GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
      GoRoute(
        path: Routes.dashboard,
        builder: (context, state) {
          return DashboardPage();
        },
      ),
    ],
  );
}
