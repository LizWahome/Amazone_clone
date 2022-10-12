import 'dart:ui';

import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/screens/results_screen.dart';
import 'package:amazon_clone/screens/sign_in.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserDetailsProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Amazon Clone",
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                //FirebaseAuth.instance.signOut();
                return const ScreenLayout();
              } else {
                return const SignIn();
              }
            },
          )),
    );
  }
}
