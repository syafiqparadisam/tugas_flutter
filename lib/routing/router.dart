import 'package:go_router/go_router.dart';
import 'package:mobile_bab2/routing/routes.dart';
import 'package:mobile_bab2/ui/home/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeScreen(context),
    ),
  ],
);
