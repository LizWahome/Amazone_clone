import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/screens/sell_screen.dart';
import 'package:amazon_clone/screens/sign_in.dart';
import 'package:amazon_clone/widgets/account_screen_appbar.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/products_show_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilis/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AccountScreenAppBar(
            preferredSize: Size.fromHeight(kAppBarHeight)),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(children: [
              const WidgetAccountScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    color: Colors.yellow,
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SellScreen())));
                    },
                    child: const Text("Sell",
                        style: TextStyle(color: Colors.black))),
              ),
              ProductShowCaseListView(
                  title: "Your Orders", children: testChildren),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: const Text(
                            "BackPack Set",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: const Text("Address: Around the block"),
                          trailing: IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {},
                          ),
                        );
                      }))
            ]),
          ),
        ));
  }
}

class WidgetAccountScreen extends StatelessWidget {
  const WidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.blueAccent,
          Colors.cyan,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.000000001),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Hello, ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 34, 34, 34),
                      fontSize: 27,
                    )),
                TextSpan(
                    text: userDetailsModel.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 32, 32, 32),
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ))
              ])),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(amazonLogoUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}
