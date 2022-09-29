import 'package:amazon_clone/screens/sign_in.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Amazon Clone",
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const SignIn(),
    );
  }
}
