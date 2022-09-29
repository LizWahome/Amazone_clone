import 'package:flutter/material.dart';

import '../utilis/color_theme.dart';
import '../utilis/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    addressController.dispose();
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
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: screenSize.height * 0.6,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign-Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                          TextFieldWidget(
                            title: "Name",
                            controller: nameController,
                            obscureText: false,
                            hintText: 'Enter your Name',
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
                          TextFieldWidget(
                            title: "Address",
                            controller: addressController,
                            obscureText: false,
                            hintText: 'Enter your Address',
                          ),
                          const SizedBox(height: 7,),
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                                color: yellowColor,
                                isLoading: false,
                                onPressed: () {},
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  color: Colors.grey,
                  isLoading: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
