import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/widgets/cart_item_widget.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

import '../utilis/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          isReadOnly: true,
          hasBackButton: false),
      body: Column(
        children: [
          UserDetailBar(
            offset: 0,
            userDetails: UserDetailsModel(name: "", address: ""),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                color: yellowColor,
                isLoading: false,
                onPressed: () {},
                child: const Text(
                  "Proceed to buy items",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CartItemWidget();
                }),
          )
        ],
      ),
    );
  }
}
