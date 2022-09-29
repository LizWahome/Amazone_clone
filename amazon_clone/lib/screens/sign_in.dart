import 'package:amazon_clone/screens/sign_up.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../utilis/color_theme.dart';
import '../utilis/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.10,
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Container(
                    height: screenSize.height * 0.5,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign-In",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                        TextFieldWidget(
                          title: "Email",
                          controller: emailController,
                          obscureText: false,
                          hintText: 'Enter your email',
                        ),
                        TextFieldWidget(
                          title: "Password",
                          controller: passwordController,
                          obscureText: true,
                          hintText: 'Enter your password',
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () {},
                              child: const Text("Sign In", style: TextStyle(color: Colors.black),)),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.grey,)),
                    const Text("New to Amazon?",
                    style: TextStyle(color: Colors.grey),),
                    Expanded(child: Container(height: 1, color: Colors.grey,)),
                  ],
                ),
                const SizedBox(height: 15,),
                CustomButton(
                  color: Colors.grey,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const SignUp())));
                  },
                  child: const Text("Create Amazon account", style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
