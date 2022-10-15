import 'package:amazon_clone/model/product_model.dart';
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
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: kAppBarHeight/2,),
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
                      return CartItemWidget(
                        product: ProductModel(
                            url:
                                "https://cdn.pixabay.com/photo/2016/12/23/07/01/game-1926907_1280.png",
                            productName: "Video games",
                            cost: 574,
                            discount: 0,
                            uid: "hsjszncdjh",
                            sellerName: "Games.com",
                            sellerUid: "ksdjasd",
                            rating: 3,
                            noOfRating: 5000),
                      );
                    }),
              ),
            ],
            
          ),
           const UserDetailBar(
                offset: 0,
              ),
        ],
      ),
    );
  }
}
