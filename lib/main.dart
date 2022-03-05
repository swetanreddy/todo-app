import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/authenticate.dart';
import 'package:todo/ui/SplashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo APP',
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
      //home: Authenticate(),
    );
  }
}
