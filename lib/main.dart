import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routing/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  debugPrint = (String? message, {int? wrapWidth}) {};
  final token = prefs.getString('token');
  await Firebase.initializeApp();
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: createRouter(token),
      debugShowCheckedModeBanner: false,
    );
  }
}
