import 'package:chatter/auth/auth_gate.dart';
import 'package:chatter/firebase_options.dart';
import 'package:chatter/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatter/themes/light_mode.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: MyApp(),)
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Chat APP',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home:  AuthGate(),
    );
  }
}
